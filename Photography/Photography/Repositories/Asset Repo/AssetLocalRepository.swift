//
//  AssetLocalRepository.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/3/23.
//

import Foundation

protocol AssetLocalRepository {
    func isImageAvailable(with name: String) -> Bool
    func saveImage(with imageName: String, data: Data, completion: @escaping (Result<Data?, ClientError>) -> Void)
    func getLocalImage(imageName: String, completion: @escaping (Result<Data?, ClientError>) -> Void)
}

struct AssetLocalRepositoryImp: AssetLocalRepository {
    private let fileManager: FileManagerImageProvider
    
    init(fileManager: FileManagerImageProvider) {
        self.fileManager = fileManager
    }
    
    func isImageAvailable(with name: String) -> Bool {
        fileManager.isImageAvailable(with: name)
    }
    
    func saveImage(with imageName: String, data: Data, completion: @escaping (Result<Data?, ClientError>) -> Void) {
        fileManager.saveImage(with: data, name: imageName)
    }

    func getLocalImage(imageName: String, completion: @escaping (Result<Data?, ClientError>) -> Void) {
        do {
            let imageData = try fileManager.getImage(with: imageName)
            completion(.success(imageData))
        } catch let error {
            completion(.failure(.localError(error as? LocalError ?? .unknown)))
        }
    }
}
