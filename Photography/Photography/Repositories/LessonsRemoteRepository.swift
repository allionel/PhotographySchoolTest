//
//  LessonsRemoteRepository.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/2/23.
//

import Foundation

protocol LessonsRemoteRepository {
    var isNetworkReachable: Bool { get }
    func getRemoteLessons(result: @escaping (Result<Lessons, ServerError>) -> Void)
}

struct LessonsRemoteRepositoryImp: LessonsRemoteRepository {
    private let client: APIClient
    
    init(client: APIClient) {
        self.client = client
    }
    
    var isNetworkReachable: Bool {
        client.isNetworkReachable
    }
    
    func getRemoteLessons(result: @escaping (Result<Lessons, ServerError>) -> Void) {
        client.request(Router.getLessons) { (response: Result<Lessons, ServerError>) in
            result(response)
        }
    }
}

extension LessonsRemoteRepositoryImp {
    enum Router: NetworkRouter {
        case getLessons
        
        var method: RequestMethod? {
            switch self {
            case .getLessons:
                return .get
            }
        }
        
        var path: String {
            switch self {
            case .getLessons:
                return "lessons/"
            }
        }
    }
}

