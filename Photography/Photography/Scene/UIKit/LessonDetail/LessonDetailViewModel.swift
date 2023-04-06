//
//  LessonDetailViewModel.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/4/23.
//

import Foundation
import Combine

final class LessonDetailViewModel: ObservableObject {
    @Published var lesson: Lesson
    @Published var videoUrl: String = ""
    @Published var downloadProgress: Double = .zero
    @Published var downloadState: DownloadState = .ready
    @Published var errorMessage: String = ""
    private let service: VideoService
    private let progressValue: PassthroughSubject<Double, Never> = .init()
    private var cancellable: [AnyCancellable] = []
    
    private var isVideoAvailable: Bool {
        service.isVideoAvailable(with: lesson.assetName)
    }
//    "http://techslides.com/demos/sample-videos/small.mp4"
    init(lesson: Lesson, service: VideoService = DependencyContainer.shared.services.videos) {
        self.lesson = lesson
        self.service = service
        progressValue.sink { [weak self] value in
            self?.downloadProgress = value
        }.store(in: &cancellable)
        checkVideoAvailablitiy()
    }
    
    func startDownloadingVideo() {
        downloadState = .downloading
        service.downloadVideo(videoName: lesson.assetName, urlString: lesson.videoUrl, progress: progressValue) { [weak self] response in
            guard let self else { return }
            switch response {
            case .success:
                self.downloadState = .done
            case .failure(let error):
                self.errorMessage = error.errorDescription
            }
        }
    }
    
    func getLocalVideo() {
        service.getLocalVideo(videoName: lesson.assetName, urlString: lesson.videoUrl) { [weak self] response in
            guard let self else { return }
            switch response {
            case .success(let url):
                self.downloadState = .done
                self.videoUrl = url.absoluteString
            case .failure(let error):
                self.errorMessage = error.errorDescription
            }
        }
    }
    
    private func checkVideoAvailablitiy() {
        if isVideoAvailable {
            getLocalVideo()
        } else {
            videoUrl = lesson.videoUrl
        }
    }
}


