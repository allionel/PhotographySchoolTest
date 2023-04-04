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
    @Published var isLoading: Bool = true

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
                DispatchQueue.main.async {
                    self.lessons = data.lessons
                    self.isLoading = false
                }
            case let .failure(error):
                self.errorText = error.errorDescription
            }
        }
    }
    
}
