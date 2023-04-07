//
//  AssetType.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/5/23.
//

import Foundation

enum AssetType {
    case image(name: String)
    case video(name: String)
}

extension AssetType {
    var fileNameWithExtension: String {
        switch self {
        case .image(let name):
            return name + .imageExtension
        case .video(let name):
            return name + .videoExtension
        }
    }
}
