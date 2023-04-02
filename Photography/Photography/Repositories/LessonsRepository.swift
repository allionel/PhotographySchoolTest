//
//  LessonsRepository.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/2/23.
//

import Foundation

struct LessonsRepository {
    private let client: APIClient

    init(client: APIClient) {
        self.client = client
    }
}

struct LessonsRemoteRepository {
}

struct LessonsLocalRepository {
}
