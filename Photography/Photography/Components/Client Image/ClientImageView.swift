//
//  ClientImageView.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/2/23.
//

import SwiftUI

struct ClientImageView: View {
    @StateObject var viewModel: ClientImageViewModel

    var body: some View {
        switch viewModel.imageViewState {
        case .loading:
            ProgressView()
                .tint(Color.surface)
        case .success(let image):
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
        case .failure:
            Image(name: .placeholder)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color.surface)
        }
    }
}

struct ClientImageView_Previews: PreviewProvider {
    static var previews: some View {
        let urlPath = "https://embed-ssl.wistia.com/deliveries/b57817b5b05c3e3129b7071eee83ecb7.jpg?image_crop_resized=1000x560"
        ClientImageView(viewModel: .init(urlString: urlPath, imageName: .constant("new_image")))
            .frame(width: 200, height: 100)            
    }
}

