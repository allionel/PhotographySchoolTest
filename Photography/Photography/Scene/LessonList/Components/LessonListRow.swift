//
//  LessonListRow.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/1/23.
//

import SwiftUI

struct LessonListRow: View {
    let image: String = "iOS-design"
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
            VStack(alignment: .leading, spacing: .zero) {
                ZStack {
                    HStack {
                        makeTitle()
                        makeArrow()
                            .padding(.trailing, 16)
                    }
                    makeDivider()
                }
            }
        }
        .frame(maxHeight: rowHeight)
    }
    
    private func makeListImage() -> some View {
        VStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .cornerRadius(.corneRadius)
                .frame(width: imageWidth)
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
                .background(Color.background)
        }
    }
}

struct LessonListRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            LessonListRow(title: "How To Choose The Correct iPhone Camera Lens asda sdas d as d")
        }
        .background(Color.background)
        .frame(height: 300)
    }
}
