//
//  LessonsRepository.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/2/23.
//

import Foundation

protocol LessonsRepository {
    func getLessons(result completion: @escaping LessonsResponse)
    func getImage(urlString: String, result: @escaping (Result<Data?, ServerError>) -> Void)
}

struct LessonsRepositoryImp: LessonsRepository {
    private let remoteRepository: LessonsRemoteRepository
    private let localRepository: LessonsLocalRepository
    
    init(remoteRepository: LessonsRemoteRepository, localRepository: LessonsLocalRepository) {
        self.remoteRepository = remoteRepository
        self.localRepository = localRepository
    }
    
    func getLessons(result completion: @escaping LessonsResponse) {
        remoteRepository.isNetworkReachable ?
            (handleResponsOnline(result: completion)) :
            (handleResponsOffline(result: completion))
    }
    
    func getImage(urlString: String, result: @escaping (Result<Data?, ServerError>) -> Void) {
        
    }
    
    private func handleResponsOnline(result completion: @escaping LessonsResponse) {
        remoteRepository.getRemoteLessons { (response: Result<Lessons, ServerError>) in
            switch response {
            case .success(let data):
                completion(.success(data))
                DispatchQueue.global(qos: .background).async {
                    saveInDatabase(with: data, completion: completion)
                }
            case .failure(let error):
                completion(.failure(.serverError(error)))
            }
        }
    }
    
    private func handleResponsOffline(result completion: @escaping LessonsResponse) {
        localRepository.load { (response: Result<Lessons, LocalError>) in
            switch response {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(.localError(error)))
            }
        }
    }
    
    private func saveInDatabase(with data: Lessons, completion: @escaping LessonsResponse) {
        do {
            try localRepository.save(data: data) { result in
                switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(.localError(error)))
                }
            }
        } catch(let error) {
            let localError: LocalError = error as? LocalError ?? .unknown
            completion(.failure(.localError(localError)))
        }
    }
}
