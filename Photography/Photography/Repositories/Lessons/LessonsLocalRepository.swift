//
//  LessonsLocalRepository.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/2/23.
//

import Foundation

 protocol LessonsLocalRepository {
    func save(data: Lesson, completion: @escaping (Result<Lesson, LocalError>) -> Void) throws
    func save(data: Lessons, completion: @escaping (Result<Lessons, LocalError>) -> Void) throws
    func load(data completion: @escaping (Result<Lessons, LocalError>) -> Void)
}

struct LessonsLocalRepositoryImp: LessonsLocalRepository {
    let database: DatabaseProvider
    
    init(database: DatabaseProvider) {
        self.database = database
    }
    
    func save(data: Lesson, completion: @escaping (Result<Lesson, LocalError>) -> Void) throws {
        do {
            try database.save(data)
            completion(.success(data))
        }
        catch(let error) {
            completion(.failure(error as? LocalError ?? .unknown))
        }
    }
    
    func save(data: Lessons, completion: @escaping (Result<Lessons, LocalError>) -> Void) throws {
        do {
            try data.lessons.forEach {
                try database.save($0)
            }
            completion(.success(data))
        }
        catch(let error) {
            completion(.failure(error as? LocalError ?? .unknown))
        }
    }
    
    func load(data completion: @escaping (Result<Lessons, LocalError>) -> Void) {
        do {
            let data: [Lesson] = try database.fetch()
            let lessons: Lessons = .init(lessons: data)
            completion(.success(lessons))
        }
        catch(let error) {
            completion(.failure(error as? LocalError ?? .unknown))
        }
    }
}
