//
//  ClientAssetProtocol.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/3/23.
//

import Foundation

public protocol ClientAssetProtocol {
    var thumbnail: String { get }
    var thumbnailLocalPath: String { get }
    var videoUrl: String { get }
    var videoLocalPath: String { get }
}
