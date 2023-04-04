//
//  LessonListRow.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/1/23.
//

import SwiftUI

struct LessonListRow: View {
    @StateObject var imageViewModel: ClientImageViewModel
    let title: String
    
    private var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    private var imageWidth: CGFloat {
        2 * screenWidth / 7
    }
    
    // We consider the max height as three lines
    // The scale of the pic is 560:1000
    //
    private var rowHeight: CGFloat {
        imageWidth * 56 / 100 + (2 * CGFloat.interlineSpacing)
    }
    
    var body: some View {
        HStack(spacing: .horizontalPadding) {
            makeListImage()
            VStack( spacing: .zero) {
                ZStack(alignment: .leading) {
                    HStack {
                        makeTitle()
                        Spacer()
                        makeArrow()
                    }
                    .padding(.vertical, .interlineSpacing)
//                    makeDivider()
                }
            }
        }
        .frame(maxHeight: rowHeight)
    }
    
    private func makeListImage() -> some View {
        VStack {
            ClientImageView(viewModel: imageViewModel)
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
        Image(systemName: .chevronRight)
            .foregroundColor(.action)
    }
    
//    private func makeDivider() -> some View {
//        VStack {
//            Spacer()
//            Divider()
//                .background(Color.border)
//        }
//    }
}

struct LessonListRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            let urlPath = "https://embed-ssl.wistia.com/deliveries/b57817b5b05c3e3129b7071eee83ecb7.jpg?image_crop_resized=1000x560"
            LessonListRow(imageViewModel: .init(urlString: urlPath, imageName: .constant("new_image")), title: "Header")
        }
        .background(Color.background)
        .frame(height: 300)
    }
}
