//
//  ServicesDependencyContainer.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/2/23.
//

import Foundation

final class ServicesDependencyContainer {
    private var repositories: RepositoriesDependencyContainer
    
    init(client: APIClient = NetworkManager(),
         database: DatabaseProvider = DatabaseManager.shared,
         fileManager: FileManagerAssetProvider = LocalFileManager.shared) {
        repositories = .init(client: client, database: database, fileManager: fileManager)
    }
    
    lazy var lessons: LessonsService = {
        LessonsServiceImp(network: repositories.lessonsRepository)
    }()
    
    lazy var images: ImageService = {
        ImageServiceImp(repository: repositories.imageRepository)
    }()
    
    lazy var videos: VideoService = {
        VideoServiceImp(repository: repositories.videoRepository)
    }()
}
