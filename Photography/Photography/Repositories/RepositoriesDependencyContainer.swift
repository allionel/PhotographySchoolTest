//
//  RepositoriesDependencyContainer.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/2/23.
//

import Foundation

final class RepositoriesDependencyContainer {
    private let client: APIClient
    private let database: DatabaseProvider
    private let fileManager: FileManagerImageProvider
    
    init(client: APIClient, database: DatabaseProvider, fileManager: FileManagerImageProvider) {
        self.client = client
        self.database = database
        self.fileManager = fileManager
    }
    
    lazy var lessonsRepository: LessonsRepository = {
        let remoteRepository: LessonsRemoteRepository = LessonsRemoteRepositoryImp(client: client)
        let localRepository: LessonsLocalRepository = LessonsLocalRepositoryImp(database: database)
        let repository: LessonsRepository = LessonsRepositoryImp(localRepository: localRepository, remoteRepository: remoteRepository)
        return repository
    }()
    
    lazy var assetRepository: AssetRepository = {
        let remoteRepository: AssetRemoteRepository = AssetRemoteRepositoryImp(client: client)
        let localRepository: AssetLocalRepository = AssetLocalRepositoryImp(fileManager: fileManager)
        let repository: AssetRepository = AssetRepositoryImp(localRepository: localRepository, remoteRepository: remoteRepository)
        return repository
    }()
}
