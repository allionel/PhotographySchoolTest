//
//  LessonDetailStatusTests.swift
//  LessonDetailStatusTests
//
//  Created by Alireza Sotoudeh on 4/7/23.
//

import XCTest
@testable import Photography

final class PhotographyTests: XCTestCase {

    private var viewModel: LessonDetailViewModel? = nil
    private var lessons: [Lesson] = []
    
    override func setUpWithError() throws {
        decodeModel()
        viewModel = .init(lesson: lessons[0])
    }

    func testStateChangeToDownloading() {
        let expectation = expectation(description: "State has changed to downloading successfuy")
        viewModel?.startDownloadingVideo()
        viewModel?.downloadState == .downloading ? expectation.fulfill() : ()
        wait(for: [expectation], timeout: 1)
    }
    
    func testVideoGetUrl() {
        let expectation = expectation(description: "Get url successfuy")
        guard let viewModel else { return }
        !viewModel.videoUrl.isEmpty ? expectation.fulfill() : ()
        wait(for: [expectation], timeout: 1)
    }
    
    func testDownloadStatusWhenIsDone() {
        let expectation = expectation(description: "View State is Change to Done successfuly")
        viewModel?.getLocalVideo()
        viewModel?.downloadState == .done ? expectation.fulfill() : ()
        wait(for: [expectation], timeout: 1)
    }
    override func tearDownWithError() throws { }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

    private func decodeModel() {
        let data = lessonMockJsonString.data(using: .utf8)!
        do {
            let res = try JSONDecoder().decode(Lessons.self, from: data)
            lessons = res.lessons
        } catch { }
    }
}

let lessonMockJsonString = """
{
    "lessons": [
        {
            "id": 950,
            "name": "The Key To Success In iPhone Photography",
            "description": "What's the secret to taking truly incredible iPhone photos? Learning how to use your iPhone camera is very important, but there's something even more fundamental to iPhone photography that will help you take the photos of your dreams! Watch this video to learn some unique photography techniques and to discover your own key to success in iPhone photography!",
            "thumbnail": "https://embed-ssl.wistia.com/deliveries/b57817b5b05c3e3129b7071eee83ecb7.jpg?image_crop_resized=1000x560",
            "video_url": "http://techslides.com/demos/sample-videos/small.mp4"
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
