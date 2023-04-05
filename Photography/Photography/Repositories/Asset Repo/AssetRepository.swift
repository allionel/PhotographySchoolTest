//
//  AssetRepository.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/3/23.
//

import Foundation
import Combine

protocol AssetRepository {
    func getImage(imageName: String, urlString: String, completion: @escaping (Result<Data?, ClientError>) -> Void)
//    func getVideo(videoName: String, urlString: String, completion: @escaping (Result<Data?, ClientError>) -> Void)
    func getVideo(videoName: String, urlString: String, progress: PassthroughSubject<Double, Never>, completion: @escaping (Result<Data?, ClientError>) -> Void)
}

struct AssetRepositoryImp: AssetRepository {
    private let localRepository: AssetLocalRepository
    private let remoteRepository: AssetRemoteRepository
    
    init(localRepository: AssetLocalRepository, remoteRepository: AssetRemoteRepository) {
        self.localRepository = localRepository
        self.remoteRepository = remoteRepository
    }
    
    func getImage(imageName: String, urlString: String, completion: @escaping (Result<Data?, ClientError>) -> Void) {
        let isAvailable = localRepository.isImageAvailable(with: imageName)
        if isAvailable {
            localRepository.getLocalImage(imageName: imageName, completion: completion)
        } else {
            remoteRepository.getRemoteImage(urlString: urlString) { response in
                switch response {
                case .success(let data):
                    completion(.success(data))
                    saveLocalImage(imageName: imageName, data: data, completion: completion)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    private func saveLocalImage(imageName: String, data: Data?, completion: @escaping (Result<Data?, ClientError>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            guard let data else { return }
            localRepository.saveImage(with: imageName, data: data, completion: completion)
        }
    }
    
    func getVideo(videoName: String, urlString: String, progress: PassthroughSubject<Double, Never>, completion: @escaping (Result<Data?, ClientError>) -> Void) {
        let isAvailable = localRepository.isVideoAvailable(with: videoName)
        if isAvailable {
            localRepository.getLocalVideo(videoName: videoName, completion: completion)
        } else {
            remoteRepository.getRemoteVideo(urlString: urlString, progress: progress) { response in
                switch response {
                case .success(let data):
                    completion(.success(data))
                    saveLocalImage(imageName: videoName, data: data, completion: completion)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
