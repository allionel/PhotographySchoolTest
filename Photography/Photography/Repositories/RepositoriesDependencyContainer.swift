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
    
    init(client: APIClient, database: DatabaseProvider) {
        self.client = client
        self.database = database
    }
    
    lazy var lessonsRepository: LessonsRepository = {
        let remoteRepository: LessonsRemoteRepository = LessonsRemoteRepositoryImp(client: client)
        let localRepository: LessonsLocalRepository = LessonsLocalRepositoryImp(database: database)
        let repository: LessonsRepository = LessonsRepositoryImp(remoteRepository: remoteRepository, localRepository: localRepository)
        return repository
    }()
}
