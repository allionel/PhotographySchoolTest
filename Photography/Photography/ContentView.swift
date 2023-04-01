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
                Text("Lessons")
                    .font(Font.title1)
                    .foregroundColor(.caption)
                Text("Lessons")
                    .font(Font.subtitle)
                    .foregroundColor(.caption)
                Text("Lessons")
                    .font(Font.regularBody)
                    .foregroundColor(.surface)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
