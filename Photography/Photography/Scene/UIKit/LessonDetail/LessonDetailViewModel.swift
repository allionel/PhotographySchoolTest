//
//  LessonDetailViewModel.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/4/23.
//

import Foundation

final class LessonDetailViewModel: ObservableObject {
    @Published var lesson: Lesson
    
    init(lesson: Lesson) {
        self.lesson = lesson
    }
}
