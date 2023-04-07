//
//  AssetsService.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/3/23.
//

import Foundation
import Combine

typealias AssetsService = ImageService & VideoService
typealias ImageResponse = (Result<Data?, ClientError>) -> Void
typealias VideoLocalResponse = (Result<URL, ClientError>) -> Void
typealias VideoRemoteResponse = (Result<Data?, ClientError>) -> Void

protocol ImageService {
    func getImage(imageName: String, urlString: String, completion: @escaping ImageResponse)
}

protocol VideoService {
    func isVideoAvailable(with name: String) -> Bool
    func downloadVideo(videoName: String, urlString: String, progress: PassthroughSubject<Double, Never>, completion: @escaping VideoRemoteResponse)
    func getLocalVideo(videoName: String, urlString: String, completion: @escaping VideoLocalResponse)
    func cancelDownloading()
}

struct ImageServiceImp: ImageService {
    private let repository: ImageRepository
    
    init(repository: ImageRepository) {
        self.repository = repository
    }
    
    func getImage(imageName: String, urlString: String, completion: @escaping ImageResponse) {
        repository.getImage(imageName: imageName, urlString: urlString, completion: completion)
    }
}

struct VideoServiceImp: VideoService {
    private let repository: VideoRepository
    
    init(repository: VideoRepository) {
        self.repository = repository
    }
    
    func isVideoAvailable(with name: String) -> Bool {
        repository.isVideoAvailable(with: name)
    }
    
    func downloadVideo(videoName: String, urlString: String, progress: PassthroughSubject<Double, Never>, completion: @escaping VideoRemoteResponse) {
        repository.downloadVideo(videoName: videoName, urlString: urlString, progress: progress, completion: completion)
    }
    
    func getLocalVideo(videoName: String, urlString: String, completion: @escaping VideoLocalResponse) {
        repository.getLocalVideo(videoName: videoName, urlString: urlString, completion: completion)
    }
    
    func cancelDownloading() {
        repository.cancelDownloading()
    }
}
