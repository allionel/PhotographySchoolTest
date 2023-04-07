//
//  LessonDetailView.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/4/23.
//

import SwiftUI

struct LessonDetailView: UIViewControllerRepresentable {
    let currentLesson: Lesson
    let lessons: [Lesson]
    
    init(currentLesson: Lesson, lessons: [Lesson]) {
        self.currentLesson = currentLesson
        self.lessons = lessons
    }
    
    func makeUIViewController(context: Context) -> LessonDetailPageViewController {
        return LessonDetailPageViewController(currentLesson: currentLesson, lessons: lessons)
    }

    func updateUIViewController(_ uiViewController: LessonDetailPageViewController, context: Context) { }
}
