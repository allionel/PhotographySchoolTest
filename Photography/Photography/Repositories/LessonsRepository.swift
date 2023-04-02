//
//  LessonsRepository.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/2/23.
//

import Foundation

typealias LessonsResponse = (Result<Lessons, ClientError>) -> Void

protocol LessonsRepository {
    func getLessons(result completion: @escaping LessonsResponse)
}

struct LessonsRepositoryImp: LessonsRepository {
    private let remoteRepository: LessonsRemoteRepository
    private let localRepository: LessonsLocalRepository
    
    init(remoteRepository: LessonsRemoteRepository, localRepository: LessonsLocalRepository = LessonsLocalRepositoryImp()) {
        self.remoteRepository = remoteRepository
        self.localRepository = localRepository
    }
    
    func getLessons(result completion: @escaping LessonsResponse) {
//        if true { // if connected to internet
//            handleResponsOnline(result: completion)
//        } else {
//            handleResponsOffline(result: completion)
//        }
    }
    
    private func handleResponsOnline(result completion: @escaping LessonsResponse) {
        remoteRepository.getRemoteLessons { (response: Result<Lessons, ServerError>) in
            switch response {
            case .success(let data):
                completion(.success(data))
                localRepository.save(data: data)
            case .failure(let error):
                completion(.failure(.serverError(error)))
            }
        }
    }
    
    private func handleResponsOffline(result completion: @escaping LessonsResponse) {
        localRepository.loadData { (response: Result<Lessons, LocalError>) in
            switch response {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(.localError(error)))
            }
        }
    }
}
