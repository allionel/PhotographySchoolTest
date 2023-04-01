//
//  LessonListRow.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/1/23.
//

import SwiftUI

struct LessonListRow: View {
    let imagePath: String
    let title: String
    
    private var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    private var imageWidth: CGFloat {
        2 * screenWidth / 7
    }
    
    // We consider the max height as three lines
    //
    private var rowHeight: CGFloat {
        imageWidth * 56 / 100 + (2 * CGFloat.verticalPadding)
    }
    var body: some View {
        HStack(spacing: 16) {
            makeListImage()
            VStack( spacing: .zero) {
                ZStack(alignment: .leading) {
                    HStack {
                        makeTitle()
                        Spacer()
                        makeArrow()
//                            .padding(.trailing, 16)
                    }
                    .padding(.vertical, .interlineSpacing)
                    makeDivider()
                }
            }
        }
        .frame(maxHeight: rowHeight)
    }
    
    private func makeListImage() -> some View {
        VStack {
            RemoteImage(path: imagePath)
                .frame(width: imageWidth)
                .cornerRadius(.corneRadius)
        }
    }
    
    private func makeTitle() -> some View {
        Text(title)
            .font(.subtitle)
            .foregroundColor(.surface)
    }
    
    private func makeArrow() -> some View {
        Image(name: .chevronRight)
            .foregroundColor(.action)
    }
    
    private func makeDivider() -> some View {
        VStack {
            Spacer()
            Divider()
                .background(Color.border)
        }
    }
}

struct LessonListRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            LessonListRow(
                imagePath: "https://embed-ssl.wistia.com/deliveries/b57817b5b05c3e3129b7071eee83ecb7.jpg?image_crop_resized=1000x560",
                title: "How To Choose The Correct iPhone Camera Lens How To Choose The Correct iPhone Camera Lens"
            )
        }
        .background(Color.background)
        .frame(height: 300)
    }
}
