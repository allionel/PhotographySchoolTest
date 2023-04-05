//
//  NetworkManager.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/2/23.
//

import Foundation
import Alamofire
import Combine

protocol APIClient {
    var isNetworkReachable: Bool { get }
    func request<T>(_: URLRequestConvertible, result: @escaping (Result<T, ServerError>) -> Void) where T: Decodable, T: Encodable
    func downloadImage(urlString: String, result: @escaping (Result<Data?, ServerError>) -> Void)
    func downloadVideo(urlString: String, progress: PassthroughSubject<Double, Never>, result: @escaping (Result<Data?, ServerError>) -> Void)
}

final class NetworkManager {
    private let sessionManager: Session
    private let decoder: JSONDecoder
    private let interceptor = Interceptor()
    
    private let progressValue: PassthroughSubject<Double, Never> = .init()
    private var cancellable: [AnyCancellable] = []
    
    required init() {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        configuration.waitsForConnectivity = true
        
        sessionManager = .init(configuration: configuration, interceptor: interceptor)
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
    
    func downloadVideo(urlString: String, progress: PassthroughSubject<Double, Never>, result: @escaping (Result<Data?, ServerError>) -> Void)  {
        guard let url = URL(string: urlString) else {
            result(.failure(ServerError.invalidRequest))
            return
        }
        let urlRequest: URLRequest = .init(url: url)

        progressValue.sink { value in
            progress.send(value)
        }.store(in: &cancellable)
        
        sessionManager
            .request(urlRequest)
            .downloadProgress { [weak self] progress in
                guard let self else { return }
                self.progressValue.send(progress.fractionCompleted)
            }.response { response in
                switch response.result {
                case let .success(data):
                    result(.success(data))
                case let .failure(error):
                    result(.failure(ServerError(rawValue: error.responseCode ?? 1002) ?? ServerError.unknown))
                }
            }
    }
    
}
