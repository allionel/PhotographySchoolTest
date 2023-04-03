//
//  ServicesDependencyContainer.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/2/23.
//

import Foundation

final class ServicesDependencyContainer {
    private var repositories: RepositoriesDependencyContainer
    
    init(client: APIClient = NetworkManager(), database: DatabaseProvider = DatabaseManager.shared) {
        repositories = .init(client: client, database: database)
    }
}
