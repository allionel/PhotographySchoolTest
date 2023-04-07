//
//  NetworkManager.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/2/23.
//

import Foundation
import Alamofire
import Combine

public protocol APIClient {
    var isNetworkReachable: Bool { get }
    func request<T>(_: URLRequestConvertible, result: @escaping (Result<T, ServerError>) -> Void) where T: Decodable, T: Encodable
    func downloadImage(urlString: String, result: @escaping (Result<Data?, ServerError>) -> Void)
    func downloadVideo(urlString: String, progress: PassthroughSubject<Double, Never>, result: @escaping (Result<Data?, ServerError>) -> Void)
    func cancelDownloading()
}

final public class NetworkManager {
    private let sessionManager: Session
    private let decoder: JSONDecoder
    private let interceptor = Interceptor()
    private var downloadRecquest: DataRequest?
    
    private let progressValue: PassthroughSubject<Double, Never> = .init()
    private var cancellable: [AnyCancellable] = []
    
    public required init() {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        configuration.waitsForConnectivity = true
        
        sessionManager = .init(configuration: configuration, interceptor: interceptor)
        decoder = .init()
    }
}

extension NetworkManager: APIClient {
    public var isNetworkReachable: Bool {
        NetworkReachabilityManager()?.isReachable ?? false
    }
    
    public func request<T>(_ endpoint: Alamofire.URLRequestConvertible, result: @escaping (Result<T, ServerError>) -> Void) where T : Decodable, T : Encodable {
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
                    print("RESPONSE: \(debugPrint(response))")
                #endif
                switch response.result {
                case let .success(model):
                    result(.success(model))
                case let .failure(error):
                    result(.failure(ServerError(rawValue: error.responseCode ?? 1002) ?? ServerError.unknown))
                }
            }
    }
    
    public func downloadImage(urlString: String, result: @escaping (Result<Data?, ServerError>) -> Void) {
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
    
    public func downloadVideo(urlString: String, progress: PassthroughSubject<Double, Never>, result: @escaping (Result<Data?, ServerError>) -> Void)  {
        guard let url = URL(string: urlString) else {
            result(.failure(ServerError.invalidRequest))
            return
        }
        let urlRequest: URLRequest = .init(url: url)

        progressValue.sink { value in
            progress.send(value)
        }.store(in: &cancellable)
        
        downloadRecquest = sessionManager
            .request(urlRequest)
            .downloadProgress { [weak self] progress in
                guard let self else { return }
                self.progressValue.send(progress.fractionCompleted)
            }.response { response in
                switch response.result {
                case let .success(data):
                    result(.success(data))
                case let .failure(error):
                    #if DEBUG
                        debugPrint("@@@ Download Video Error: ", error.localizedDescription)
                    #endif
                    result(.failure(ServerError(rawValue: error.responseCode ?? 1002) ?? ServerError.unknown))
                }
            }
    }
    
    public func cancelDownloading() {
        downloadRecquest?.cancel()
    }
}
