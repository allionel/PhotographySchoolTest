//
//  RepositoriesDependencyContainer.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/2/23.
//

import Foundation

final class RepositoriesDependencyContainer {
    private let client: APIClient
    
    init(client: APIClient = NetworkManager()) {
        self.client = client
    }
    
    lazy var lessonsRepository: LessonsRepository = {
        .init(client: client)
    }()
}
