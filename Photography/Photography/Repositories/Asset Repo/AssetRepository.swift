//
//  AssetRepository.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/3/23.
//

import Foundation
import Combine

typealias AssetRepository = ImageRepository & VideoRepository

protocol ImageRepository {
    func getImage(imageName: String, urlString: String, completion: @escaping ImageResponse)
}

protocol VideoRepository {
    func isVideoAvailable(with name: String) -> Bool 
    func downloadVideo(videoName: String, urlString: String, progress: PassthroughSubject<Double, Never>, completion: @escaping VideoRemoteResponse)
    func getLocalVideo(videoName: String, urlString: String, completion: @escaping VideoLocalResponse)
}


struct AssetRepositoryImp {
    private let localRepository: AssetLocalRepository
    private let remoteRepository: AssetRemoteRepository
    
    init(localRepository: AssetLocalRepository, remoteRepository: AssetRemoteRepository) {
        self.localRepository = localRepository
        self.remoteRepository = remoteRepository
    }
    
    private func saveLocalImage(imageName: String, data: Data?, completion: @escaping ImageResponse) {
        guard let data else { return }
        localRepository.saveImage(with: imageName, data: data, completion: completion)
    }
    
    private func saveLocalVideo(videoName: String, data: Data?, completion: @escaping ImageResponse) {
        guard let data else { return }
        localRepository.saveVideo(with: videoName, data: data, completion: completion)
    }
}

extension AssetRepositoryImp: ImageRepository {
    func getImage(imageName: String, urlString: String, completion: @escaping (Result<Data?, ClientError>) -> Void) {
        let isAvailable = localRepository.isImageAvailable(with: imageName)
        if isAvailable {
            localRepository.getLocalImage(imageName: imageName, completion: completion)
        } else {
            remoteRepository.getRemoteImage(urlString: urlString) { response in
                switch response {
                case .success(let data):
                    completion(.success(data))
                    DispatchQueue.global(qos: .background).async {
                        saveLocalImage(imageName: imageName, data: data, completion: completion)
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}

extension AssetRepositoryImp: VideoRepository {
    func isVideoAvailable(with name: String) -> Bool {
        localRepository.isVideoAvailable(with: name)
    }
    
    func downloadVideo(videoName: String, urlString: String, progress: PassthroughSubject<Double, Never>, completion: @escaping VideoRemoteResponse) {
        remoteRepository.getRemoteVideo(urlString: urlString, progress: progress) { response in
            switch response {
            case .success(let data):
                completion(.success(data))
                DispatchQueue.global(qos: .background).async {
                    saveLocalVideo(videoName: videoName, data: data, completion: completion)
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getLocalVideo(videoName: String, urlString: String, completion: @escaping VideoLocalResponse) {
        localRepository.getLocalVideo(videoName: videoName, completion: completion)
    }
}
