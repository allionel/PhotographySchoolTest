//
//  LessonListTemplate.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/2/23.
//

import SwiftUI

struct LessonListTemplate: View {
    let data: [Lesson]
    @State private var nextPage: Bool = false
    
    var body: some View {
        List {
            ForEach(data) { data in
                NavigationLink {
                    LessonDetailView()
                        .edgesIgnoringSafeArea(.all)
                } label: {
                    LessonListRow(imageViewModel: .init(urlString: data.thumbnail, imageName: .constant(data.id.toString)), title: data.name)
                        .listRowBackground(Color.clear)
//                        .onTapGesture {
//                            nextPage = true
//                        }
//                        .navigationDestination(isPresented: $nextPage) {
//                            LessonDetailView()
//                                .edgesIgnoringSafeArea(.all)
//                        }
                }.listRowBackground(Color.clear)

                
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        
    }
}

struct LessonListTemplate_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LessonListTemplate(data: data)
                .navigationTitle("Page 1")
        }
    }
    
    private static var data: [Lesson] = [
        .init(id: 11, name: "This is Karen", description: "", thumbnail: "https://embed-ssl.wistia.com/deliveries/b57817b5b05c3e3129b7071eee83ecb7.jpg?image_crop_resized=1000x560", videoUrl: ""),
        .init(id: 22, name: "This is Number one", description: "", thumbnail: "https://embed-ssl.wistia.com/deliveries/f7105de283304e0dc6fe40e5abbf778f.jpg?image_crop_resized=1000x560", videoUrl: "")
    ]
}
