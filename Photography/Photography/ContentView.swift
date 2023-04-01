//
//  ContentView.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/1/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.background
            VStack {
                LessonListRow(
                    imagePath: "https://embed-ssl.wistia.com/deliveries/b57817b5b05c3e3129b7071eee83ecb7.jpg?image_crop_resized=1000x560",
                    title: "How To Choose The Correct iPhone Camera Lens asda sdas d as d"
                )
            }
            .padding(.horizontal, 16)
            .frame(height: 300)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
