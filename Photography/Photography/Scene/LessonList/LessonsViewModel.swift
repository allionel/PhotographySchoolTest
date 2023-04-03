//
//  LessonsViewModel.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/3/23.
//

import Foundation
import SwiftUI

final class LessonsViewModel: ObservableObject {
    @Published var lessons: [Lesson] = []
    @Published var errorText: String = ""
    let service: LessonsService
    
    init(service: LessonsService = DependencyContainer.shared.services.lessons) {
        self.service = service
        fetchData()
    }
    
    private func fetchData() {
        service.getLessons { [weak self] response in
            guard let self else { return }
            switch response {
            case let .success(data):
                self.lessons = data.lessons
            case let .failure(error):
                self.errorText = error.errorDescription
            }
        }
    }
    
}
