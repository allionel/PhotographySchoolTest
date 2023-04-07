//
//  PhotographyTests.swift
//  PhotographyTests
//
//  Created by Alireza Sotoudeh on 4/7/23.
//

import XCTest
@testable import Photography

final class PhotographyTests: XCTestCase {

    let viewModel: LessonDetailViewModel = .init(lesson: <#T##Lesson#>)
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

    func f() {
        let string = "[{\"form_id\":3465,\"canonical_name\":\"df_SAWERQ\",\"form_name\":\"Activity 4 with Images\",\"form_desc\":null}]"
        let data = string.data(using: .utf8)!
        do {
            if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>]
            {
               print(jsonArray) // use the json here
            } else {
                print("bad json")
            }
        } catch let error as NSError {
            print(error)
        }
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

let LessonMockJsonString = """
{
    "lessons": [
        {
            "id": 950,
            "name": "The Key To Success In iPhone Photography",
            "description": "What's the secret to taking truly incredible iPhone photos? Learning how to use your iPhone camera is very important, but there's something even more fundamental to iPhone photography that will help you take the photos of your dreams! Watch this video to learn some unique photography techniques and to discover your own key to success in iPhone photography!",
            "thumbnail": "https://embed-ssl.wistia.com/deliveries/b57817b5b05c3e3129b7071eee83ecb7.jpg?image_crop_resized=1000x560",
            "video_url": "https://embed-ssl.wistia.com/deliveries/cc8402e8c16cc8f36d3f63bd29eb82f99f4b5f88/accudvh5jy.mp4"
        },
        {
            "id": 7991,
            "name": "How To Choose The Correct iPhone Camera Lens",
            "description": "If your iPhone has more than one lens, how do you choose which lens to use? And which lens is best for different photography genres? It turns out that you'll get dramatically different results depending on which lens you use. Watch this video from our breakthrough iPhone Photo Academy course and discover how to choose the correct iPhone camera lens.",
            "thumbnail": "https://embed-ssl.wistia.com/deliveries/f7105de283304e0dc6fe40e5abbf778f.jpg?image_crop_resized=1000x560",
            "video_url": "https://embed-ssl.wistia.com/deliveries/db6cd74cf31ff8afca1f71b3c12fd820dcbde404/oazth83ovc.mp4"
        }
    ]
}
"""
