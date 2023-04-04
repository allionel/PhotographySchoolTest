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
         fileManager: FileManagerImageProvider = LocalFileManager.shared) {
        repositories = .init(client: client, database: database, fileManager: fileManager)
    }
    
    lazy var lessons: LessonsService = {
        LessonsServiceImp(network: repositories.lessonsRepository)
    }()
    
    lazy var assets: AssetsService = {
        AssetsServiceImp(network: repositories.assetRepository)
    }()
}
