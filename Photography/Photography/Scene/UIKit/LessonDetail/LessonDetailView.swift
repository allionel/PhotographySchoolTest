//
//  LessonDetailView.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/4/23.
//

import SwiftUI

struct LessonDetailView: UIViewControllerRepresentable {
    let viewModel: LessonDetailViewModel
    init(viewModel: LessonDetailViewModel) {
        self.viewModel = viewModel
    }
    
    func makeUIViewController(context: Context) -> LessonDetailViewController {
        return LessonDetailViewController(viewModel: viewModel)
    }

    func updateUIViewController(_ uiViewController: LessonDetailViewController, context: Context) { }
}
