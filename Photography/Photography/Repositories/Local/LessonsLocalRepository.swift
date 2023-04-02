//
//  LessonsLocalRepository.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/2/23.
//

import Foundation

protocol LessonsLocalRepository {
    func save(data: Lessons)
    func loadData(data completion: @escaping (Result<Lessons, LocalError>) -> Void)
}

struct LessonsLocalRepositoryImp: LessonsLocalRepository {
    func save(data: Lessons) {
        
    }
    
    func loadData(data completion: @escaping (Result<Lessons, LocalError>) -> Void) {
        
    }
    
    // Fetch from database
    
}
