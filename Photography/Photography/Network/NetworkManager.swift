//
//  NetworkManager.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/2/23.
//

import Foundation
import Alamofire

protocol APIClient {
    var isNetworkReachable: Bool { get }
    func request<T>(_: URLRequestConvertible, result: @escaping (Result<T, ServerError>) -> Void) where T: Decodable, T: Encodable
    func downloadImage(urlString: String, result: @escaping (Result<Data?, ServerError>) -> Void) 
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
    var isNetworkReachable: Bool {
        NetworkReachabilityManager()?.isReachable ?? false
    }
    
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
    
    func downloadImage(urlString: String, result: @escaping (Result<Data?, ServerError>) -> Void) {
        guard let url = URL(string: urlString) else {
            result(.failure(ServerError.invalidRequest))
            return
        }
        let urlRequest: URLRequest = .init(url: url)
        
        sessionManager
            .request(urlRequest)
            .response { response in
                switch response.result {
                case let .success(data):
                    result(.success(data))
                case let .failure(error):
                    result(.failure(ServerError(rawValue: error.responseCode ?? 1002) ?? ServerError.unknown))
                }
            }
    }
    
}
