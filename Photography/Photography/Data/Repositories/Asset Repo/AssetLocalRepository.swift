//
//  AssetLocalRepository.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/3/23.
//

import Foundation


typealias AssetLocalRepository = ImageLocalRepository & VideoLocalRepository

protocol ImageLocalRepository {
    func isImageAvailable(with name: String) -> Bool
    func saveImage(with imageName: String, data: Data, completion: @escaping ImageResponse)
    func getLocalImage(imageName: String, completion: @escaping ImageResponse)
}

protocol VideoLocalRepository {
    func isVideoAvailable(with name: String) -> Bool
    func saveVideo(with videoName: String, data: Data, completion: @escaping VideoRemoteResponse)
    func getLocalVideo(videoName: String, completion: @escaping VideoLocalResponse)
}

struct AssetLocalRepositoryImp {
    private let fileManager: FileManagerAssetProvider
    
    init(fileManager: FileManagerAssetProvider) {
        self.fileManager = fileManager
    }
}

extension AssetLocalRepositoryImp: ImageLocalRepository {
    func isImageAvailable(with name: String) -> Bool {
        fileManager.isImageAvailable(with: name)
    }
    
    func saveImage(with imageName: String, data: Data, completion: @escaping ImageResponse) {
        fileManager.saveImage(with: data, name: imageName)
    }

    func getLocalImage(imageName: String, completion: @escaping ImageResponse) {
        do {
            let imageData = try fileManager.getImage(with: imageName)
            completion(.success(imageData))
        } catch let error {
            completion(.failure(.localError(error as? LocalError ?? .unknown)))
        }
    }
}

extension AssetLocalRepositoryImp: VideoLocalRepository {
    func isVideoAvailable(with name: String) -> Bool {
        fileManager.isVideoAvailable(with: name)
    }
    
    func saveVideo(with videoName: String, data: Data, completion: @escaping VideoRemoteResponse) {
        fileManager.saveVideo(with: data, name: videoName)
    }
    
    func getLocalVideo(videoName: String, completion: @escaping VideoLocalResponse) {
        do {
            let videoUrl = try fileManager.getVideo(with: videoName)
            completion(.success(videoUrl))
        } catch let error {
            completion(.failure(.localError(error as? LocalError ?? .unknown)))
        }
    }
}
