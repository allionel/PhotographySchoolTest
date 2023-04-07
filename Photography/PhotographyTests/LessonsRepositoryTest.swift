//
//  RepositoryTest.swift
//  PhotographyTests
//
//  Created by Alireza Sotoudeh on 4/7/23.
//

import XCTest
@testable import Photography

final class RepositoryTest: XCTestCase {

    private var network: APIClient = NetworkManager()
    private var database: DatabaseProvider? = nil
    private var lessonRemoteRepo: LessonsRemoteRepository? = nil
    private var lessonLocalRepo: LessonsLocalRepository? = nil
    private let imageUrl = "https://embed-ssl.wistia.com/deliveries/b57817b5b05c3e3129b7071eee83ecb7.jpg?image_crop_resized=1000x560"
 
    override func setUpWithError() throws {
        factoryResolve()
    }

     func testGetLessonViaRepository() throws {
         let expectation = expectation(description: "Repository fetch correctly")
         mainLessonRepository?.getLessons { (reponse: Result<Lessons, ClientError>) in
             if case .success = reponse { expectation.fulfill() }
         }
         wait(for: [expectation], timeout: 3)
     }

    func testSaveInDatabase() {
        let expectation = expectation(description: "Data saved in database successfuly")
        lessonRemoteRepo?.getRemoteLessons { (response: Result<Lessons, ServerError>) in
            if case .success(let data) = response {
                guard let lesson = data.lessons.first else { return }
                do {
                    try self.lessonLocalRepo?.save(data: lesson) { (response: Result<Lesson, LocalError>) in
                        if case .success = response { expectation.fulfill() }
                    }
                } catch { }
            }
        }
        wait(for: [expectation], timeout: 3)
    }

    func testLoadFromDatabase() {
        let expectation = expectation(description: "Data load from database successfuly")
        lessonLocalRepo?.load { (response: Result<Lessons, LocalError>) in
            if case .success = response { expectation.fulfill() }
        }
        wait(for: [expectation], timeout: 3)
        
    }
    
    override func tearDownWithError() throws {
        lessonRemoteRepo = nil
        lessonLocalRepo = nil
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    private func factoryResolve() {
        database = DatabaseManager.shared
        lessonRemoteRepo = LessonsRemoteRepositoryImp(client: network)
        lessonLocalRepo = LessonsLocalRepositoryImp(database: database!)
    }
    
    private lazy var mainLessonRepository: LessonsRepository? = {
        guard let lessonLocalRepo, let lessonRemoteRepo else { return nil }
        let repository: LessonsRepository = LessonsRepositoryImp(localRepository: lessonLocalRepo, remoteRepository: lessonRemoteRepo)
        return repository
    }()
}
