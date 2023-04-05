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
    @Published var downloadProgress: Double = .zero
    @Published var errorMessage: String = ""
    @Published var localVideoUrl: URL? = nil
    @Published var didFinishDownload: Bool = false
    private let service: VideoService
    private let progressValue: PassthroughSubject<Double, Never> = .init()
    private var cancellable: [AnyCancellable] = []
    
    init(lesson: Lesson, service: VideoService = DependencyContainer.shared.services.videos) {
        self.lesson = lesson
        self.service = service
        progressValue.sink { [weak self] value in
            self?.downloadProgress = value
        }.store(in: &cancellable)
    }
    
    func downloadVideo() {
        service.downloadVideo(videoName: lesson.id.toString, urlString: lesson.videoUrl, progress: progressValue) { [weak self] response in
            guard let self else { return }
            switch response {
            case .success:
                self.didFinishDownload = true
            case .failure(let error):
                self.errorMessage = error.errorDescription
            }
        }
    }
    
    func getLocalVideo() {
        service.getLocalVideo(videoName: lesson.id.toString, urlString: lesson.videoUrl) { [weak self] response in
            guard let self else { return }
            switch response {
            case .success(let url):
                self.localVideoUrl = url
            case .failure(let error):
                self.errorMessage = error.errorDescription
            }
        }
    }
}
