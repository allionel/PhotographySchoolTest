//
//  AssetsService.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/3/23.
//

import Foundation
import Combine

typealias AssetsResponse = (Result<Data?, ClientError>) -> Void

protocol AssetsService {
    func getImage(imageName: String, urlString: String, completion: @escaping AssetsResponse)
    func getVideo(videoName: String, urlString: String, progress: PassthroughSubject<Double, Never>, completion: @escaping (Result<Data?, ClientError>) -> Void)
}

struct AssetsServiceImp: AssetsService {
    private let network: AssetRepository

    init(network: AssetRepository) {
        self.network = network
    }

    func getImage(imageName: String, urlString: String, completion: @escaping AssetsResponse) {
        network.getImage(imageName: imageName, urlString: urlString, completion: completion)
    }
    
    func getVideo(videoName: String, urlString: String, progress: PassthroughSubject<Double, Never>, completion: @escaping (Result<Data?, ClientError>) -> Void) {
        network.getVideo(videoName: videoName, urlString: urlString, progress: progress, completion: completion)
    }
}
