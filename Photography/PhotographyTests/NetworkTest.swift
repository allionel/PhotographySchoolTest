//
//  NetworkTest.swift
//  PhotographyTests
//
//  Created by Alireza Sotoudeh on 4/7/23.
//

import XCTest
import Combine
@testable import Photography

final class NetworkTest: XCTestCase {

    private var network: APIClient = NetworkManager()
    private let imageUrl = "https://embed-ssl.wistia.com/deliveries/b57817b5b05c3e3129b7071eee83ecb7.jpg?image_crop_resized=1000x560"
    private let videoUrl = "http://techslides.com/demos/sample-videos/small.mp4"
    private let progressValue: PassthroughSubject<Double, Never> = .init()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNetworkReachability() throws {
        let expectation = expectation(description: "Test if network is reachable")
        network.isNetworkReachable ? expectation.fulfill() : ()
        wait(for: [expectation], timeout: 3)
    }
    
    func testGeneralRequest() throws {
        let expectation = expectation(description: "Request fetch data successfuly")
        network.request(Router.getLessons) { (response: Result<LessonsModel, ServerError>) in
            switch response {
            case .success: expectation.fulfill()
            case .failure: ()
            }
        }
        wait(for: [expectation], timeout: 3)
    }
    
    func testDecodingRequest() throws {
        let expectation = expectation(description: "Request fetch data Decode successfuly")
        network.request(Router.getLessons) { (response: Result<LessonsModel, ServerError>) in
            switch response {
            case let .success(data):
                guard let data = data.lessons.first(where: { $0.id == 950 }) else { return }
                data.name == "The Key To Success In iPhone Photography" ? expectation.fulfill() : ()
            case .failure: ()
            }
        }
        wait(for: [expectation], timeout: 3)
    }
    
    func testDownloadImage() throws {
        let expectation = expectation(description: "Image Downloaded successfuly")
        network.downloadImage(urlString: imageUrl) { (response: Result<Data?, ServerError>) in
            if case .success = response { expectation.fulfill() }
        }
        wait(for: [expectation], timeout: 3)
    }
    
    func testDownloadVideo() throws {
        let expectation = expectation(description: "Video Downloaded successfuly")
        network.downloadVideo(urlString: videoUrl, progress: progressValue) { (response: Result<Data?, ServerError>) in
            if case .success = response { expectation.fulfill() }
        }
        wait(for: [expectation], timeout: 10)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    enum Router: NetworkRouter {
        case getLessons
        var method: RequestMethod? { return .get }
        var path: String { return "lessons" }
    }
}

struct LessonsModel: Codable {
    let lessons: [LessonModel]
}

struct LessonModel: Codable {
    public let id: Int
    public let name: String
    public let description: String
}
