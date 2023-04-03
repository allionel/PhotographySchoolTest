//
//  ClientImage.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/3/23.
//

import SwiftUI

struct ClientImage: View {
    let asset: ClientAssetProtocol

    var body: some View {
        if asset.thumbnailLocalPath.isEmpty {
            Image(asset.thumbnailLocalPath)
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
//            RemoteImage(path: asset.thumbnail)
        }
    }
}
