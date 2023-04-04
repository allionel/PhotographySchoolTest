//
//  ClientImageViewModel.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/3/23.
//

import SwiftUI

enum ClientImageViewState {
    case loading
    case success(UIImage)
    case failure(Error)
}

final class ClientImageViewModel: ObservableObject {
    @Published var imageViewState: ClientImageViewState = .loading
    @Published var errorMessage: String = ""
    @Binding private var imageName: String
    private let urlString: String
    private let service: AssetsService

    init(urlString: String,
         service: AssetsService = DependencyContainer.shared.services.assets,
         imageName: Binding<String>) {
        _imageName = imageName
        self.urlString = urlString
        self.service = service
        fetchImage()
    }
    
    private func fetchImage() {
        service.getImage(imageName: imageName, urlString: urlString) { [weak self] response in
            guard let self else { return }
            switch response {
            case .success(let data):
                guard let data, let uiImage = UIImage(data: data) else {
                    let error = ClientError.localError(.outputProcessFailed)
                    self.errorMessage = error.errorDescription
                    self.imageViewState = .failure(error)
                    return
                }
                self.imageViewState = .success(uiImage)
            case .failure(let error):
                self.imageViewState = .failure(error)
                self.errorMessage = error.errorDescription
            }
        }
    }
}
