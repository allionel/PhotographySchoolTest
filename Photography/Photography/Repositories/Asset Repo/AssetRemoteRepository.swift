//
//  AssetRemoteRepository.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/3/23.
//

import Foundation
import Combine

protocol AssetRemoteRepository {
    func getRemoteImage(urlString: String, completion: @escaping (Result<Data?, ClientError>) -> Void)
    func getRemoteVideo(urlString: String, progress: PassthroughSubject<Double, Never>, completion: @escaping (Result<Data?, ClientError>) -> Void)
}

struct AssetRemoteRepositoryImp: AssetRemoteRepository {
    private let client: APIClient
    
    init(client: APIClient) {
        self.client = client
    }
    
    func getRemoteImage(urlString: String, completion: @escaping (Result<Data?, ClientError>) -> Void) {
        client.downloadImage(urlString: urlString) { (response: Result<Data?, ServerError>) in
            switch response {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(.serverError(error)))
            }
        }
    }
    
    func getRemoteVideo(urlString: String, progress: PassthroughSubject<Double, Never>, completion: @escaping (Result<Data?, ClientError>) -> Void) {
        client.downloadVideo(urlString: urlString, progress: progress) { (response: Result<Data?, ServerError>) in
            switch response {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(.serverError(error)))
            }
        }
    }
}
