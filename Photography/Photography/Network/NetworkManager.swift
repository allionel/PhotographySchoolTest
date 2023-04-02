//
//  NetworkManager.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/2/23.
//

import Foundation
import Alamofire

protocol APIClient {
    func request<T>(_: URLRequestConvertible, result: @escaping (Result<T, ServerError>) -> Void) where T: Decodable, T: Encodable
}

final class NetworkManager {
    private let sessionManager: Session
    private let decoder: JSONDecoder
    
    required init() {
        let config = URLSessionConfiguration.af.default
        config.timeoutIntervalForRequest = 60
        config.timeoutIntervalForResource = 60
        
        sessionManager = .init(configuration: config)
        decoder = .init()
    }
}

extension NetworkManager: APIClient {
    func request<T>(_ endpoint: Alamofire.URLRequestConvertible, result: @escaping (Result<T, ServerError>) -> Void) where T : Decodable, T : Encodable {
        guard let urlRequest = try? endpoint.asURLRequest() else {
            result(.failure(ServerError.invalidRequest))
            return
        }
        let request = sessionManager.request(urlRequest)

        #if DEBUG
            print("REQUEST: \(debugPrint(request))")
        #endif

        request
            .validate()
            .responseDecodable(of: T.self) { response in
                #if DEBUG
                    print("Response: \(debugPrint(response))")
                #endif
                switch response.result {
                case let .success(model):
                    result(.success(model))
                case let .failure(error):
                    result(.failure(ServerError(rawValue: error.responseCode ?? 1002) ?? ServerError.unknown))
                }
            }
    }
    
}
