//
//  LessonListView.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/1/23.
//

import SwiftUI

struct LessonListView: View {
    @ObservedObject var viewModel: LessonsViewModel

    init() {
        UINavigationBar.appearance().barStyle = .black
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.caption]
        viewModel = .init()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color
                    .background
                    .ignoresSafeArea()
                if viewModel.isLoading {
                    ProgressView()
                        .tint(Color.surface)
                } else {
                    LessonListTemplate(data: viewModel.lessons)
                }
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle(String.lessonsPageTitle.localized)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct LessonListView_Previews: PreviewProvider {
    static var previews: some View {
        LessonListView()
    }
}
