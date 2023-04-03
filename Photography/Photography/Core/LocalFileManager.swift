//
//  LocalFileManager.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/3/23.
//

import Foundation
import class UIKit.UIImage

final class LocalFileManager: Singleton {
    static var shared: LocalFileManager = .init()
    private init() { }
    
    func saveImage(with data: Data, name: String) {
        guard let fileURL = getUrlForImage(imageName: name) else { return }
        createPathIfNotExist(with: fileURL)
        writeToFile(with: data, fileURL: fileURL)
    }
    
    func getImage(name: String) -> UIImage? {
        guard
            let fileURL = getUrlForImage(imageName: name),
            FileManager.default.fileExists(atPath: fileURL.path)
        else { return nil }
        return .init(contentsOfFile: fileURL.path)
    }
    
    private func createPathIfNotExist(with fileURL: URL) {
        do {
            if !FileManager.default.fileExists(atPath: fileURL.path) {
                try FileManager.default.createDirectory(at: fileURL, withIntermediateDirectories: true)
            }
        } catch let error {
            #if DEBUG
            print("couldn't create dir at path", error)
            #endif
        }
    }
    
    private func writeToFile(with data: Data, fileURL: URL) {
        do {
            try data.write(to: fileURL)
        } catch let error {
            #if DEBUG
            debugPrint("Error saving message", error)
            #endif
        }
    }
    
    private func getUrlForImage(imageName: String) -> URL? {
        guard let documentDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        let fileURL = documentDirectory.appendingPathComponent(imageName + ".jpg")
        return fileURL
    }
}
