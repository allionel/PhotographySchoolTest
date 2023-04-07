//
//  LocalFileManager.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/3/23.
//

import Foundation
import class UIKit.UIImage

typealias FileManagerAssetProvider =  FileManagerImageProvider & FileManagerVideoProvider

protocol FileManagerImageProvider {
    func isImageAvailable(with name: String) -> Bool
    func saveImage(with data: Data, name: String)
    func getImage(with name: String) throws -> Data?
}

protocol FileManagerVideoProvider {
    func isVideoAvailable(with name: String) -> Bool
    func saveVideo(with data: Data, name: String)
    func getVideo(with name: String) throws -> URL
}

final class LocalFileManager: Singleton {
    static var shared: LocalFileManager = .init()
    private init() { }
    
    private func writeToFile(with data: Data, fileURL: URL) {
        do {
            try data.write(to: fileURL)
        } catch let error {
            #if DEBUG
            debugPrint("Error saving message", error)
            #endif
        }
    }
    
    private func getUrlFor(asset: AssetType) -> URL? {
        guard let documentDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        let fileURL = documentDirectory.appendingPathComponent(asset.fileNameWithExtension)
        return fileURL
    }
}

extension LocalFileManager: FileManagerImageProvider {
    func isImageAvailable(with name: String) -> Bool {
        guard let fileURL = getUrlFor(asset: .image(name: name)),
              FileManager.default.fileExists(atPath: fileURL.path)
        else { return false }
        return true
    }
    
    func saveImage(with data: Data, name: String) {
        guard let fileURL = getUrlFor(asset: .image(name: name)) else { return }
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.writeToFile(with: data, fileURL: fileURL)
        }
    }
    
    func getImage(with name: String) throws -> Data? {
        guard let fileURL = getUrlFor(asset: .image(name: name)) else { throw LocalError.unableToRead }
        guard let image = UIImage(contentsOfFile: fileURL.path),
              let data = image.jpegData(compressionQuality: 1) else { throw LocalError.imageProcessFailed }
        guard FileManager.default.fileExists(atPath: fileURL.path) else { throw LocalError.notAvailable }
        return data
    }
}

extension LocalFileManager: FileManagerVideoProvider {
    func isVideoAvailable(with name: String) -> Bool {
        guard let fileURL = getUrlFor(asset: .video(name: name)),
              FileManager.default.fileExists(atPath: fileURL.path)
        else { return false }
        return true
    }
    
    func saveVideo(with data: Data, name: String) {
        guard let fileURL = getUrlFor(asset: .video(name: name)) else { return }
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.writeToFile(with: data, fileURL: fileURL)
        }
    }
    
    func getVideo(with name: String) throws -> URL {
        guard let fileURL = getUrlFor(asset: .video(name: name)) else { throw LocalError.unableToRead }
        return fileURL
    }
    
}
