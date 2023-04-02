//
//  LessonListView.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/1/23.
//

import SwiftUI

struct LessonListView: View {
    init() {
        UINavigationBar.appearance().barStyle = .black
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.caption]
    }
    
    private static var data: [Lesson] = [
        .init(id: 11, name: "This is Karen", description: "", thumbnail: "https://embed-ssl.wistia.com/deliveries/b57817b5b05c3e3129b7071eee83ecb7.jpg?image_crop_resized=1000x560", videoUrl: ""),
        .init(id: 22, name: "This is Number one", description: "", thumbnail: "https://embed-ssl.wistia.com/deliveries/f7105de283304e0dc6fe40e5abbf778f.jpg?image_crop_resized=1000x560", videoUrl: "")
    ]
    var body: some View {
        NavigationView {
            ZStack {
                Color
                    .background
                    .ignoresSafeArea()
                LessonListTemplate(data: LessonListView.data)
                    
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