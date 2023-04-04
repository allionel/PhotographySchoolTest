//
//  AssetsService.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/3/23.
//

import Foundation

typealias AssetsResponse = (Result<Data?, ClientError>) -> Void

protocol AssetsService {
    func getImage(imageName: String, urlString: String, completion: @escaping AssetsResponse)
}

struct AssetsServiceImp: AssetsService {
    private let network: AssetRepository

    init(network: AssetRepository) {
        self.network = network
    }

    func getImage(imageName: String, urlString: String, completion: @escaping AssetsResponse) {
        network.getImage(imageName: imageName, urlString: urlString, completion: completion)
    }
}
