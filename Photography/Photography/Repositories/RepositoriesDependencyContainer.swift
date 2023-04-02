//
//  RepositoriesDependencyContainer.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/2/23.
//

import Foundation

final class RepositoriesDependencyContainer {
    private let client: APIClient
    
    init(client: APIClient) {
        self.client = client
    }
    
    lazy var lessonsRepository: LessonsRepository = {
        let remoteRepository: LessonsRemoteRepository = LessonsRemoteRepositoryImp(client: client)
        let localRepository: LessonsLocalRepository = LessonsLocalRepositoryImp()
        let repository = LessonsRepositoryImp(remoteRepository: remoteRepository, localRepository: localRepository)
        return repository
    }()
}
