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
    private let service: AssetsService
    private let progressValue: PassthroughSubject<Double, Never> = .init()
    private var cancellable: [AnyCancellable] = []
    
    init(lesson: Lesson, service: AssetsService = DependencyContainer.shared.services.assets) {
        self.lesson = lesson
        self.service = service
        progressValue.sink { [weak self] value in
            self?.downloadProgress = value
        }.store(in: &cancellable)
        downloadVideo()
    }
    
    func downloadVideo() {
        service.getVideo(videoName: lesson.id.toString, urlString: lesson.videoUrl, progress: progressValue) { [weak self] response in
            guard let self else { return }
            switch response {
            case .success(let data):
                ()
            case .failure(let error):
                ()
            }
        }
    }
}
