//
//  RemoteImage.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/2/23.
//

import SwiftUI

struct RemoteImageView: View {
    let viewModel: RemoteImageViewModel

    init(viewModel: RemoteImageViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack { }
    }
//    var body: some View {
//        AsyncImage(url: .init(string: path)) { phase in
//            switch phase {
//            case .empty:
//                ProgressView()
//                    .tint(Color.surface)
//            case .success(let image):
//                image.resizable()
//                    .aspectRatio(contentMode: .fit)
//            case .failure:
//                Image(name: .placeholder)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .foregroundColor(Color.surface)
//            @unknown default:
//                EmptyView()
//            }
//        }
//    }
}

//struct RemoteImage_Previews: PreviewProvider {
//    static var previews: some View {
//        RemoteImage(path: "https://embed-ssl.wistia.com/deliveries/b57817b5b05c3e3129b7071eee83ecb7.jpg?image_crop_resized=1000x560")
//            .frame(width: 200, height: 100)
//    }
//}

final class RemoteImageViewModel: ObservableObject {
    let urlString: String
    let service: LessonsService
    
    init(urlString: String, service: LessonsService = DependencyContainer.shared.services.lessons) {
        self.urlString = urlString
        self.service = service
        fetchImage()
    }
    
    private func fetchImage() {
//        service.getImage(urlString: urlString) { response in
//            switch response {
//            case .success(let data):
//
//            case .failure(let error):
//                <#code#>
//            }
//        }
    }
}


enum ClientImageViewState {
    case loading
    case local(String)
    case success(UIImage)
    case failure(Error)
}
