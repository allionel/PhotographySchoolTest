//
//  LessonsService.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/3/23.
//

import Foundation

typealias LessonsResponse = (Result<Lessons, ClientError>) -> Void

protocol LessonsService {
    func getLessons(result completion: @escaping LessonsResponse)
}

struct LessonsServiceImp: LessonsService {
    private let network: LessonsRepository

    init(network: LessonsRepository) {
        self.network = network
    }

    func getLessons(result completion: @escaping LessonsResponse) {
        network.getLessons(result: completion)
    }
}
