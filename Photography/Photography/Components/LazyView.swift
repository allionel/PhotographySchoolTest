//
//  LazyView.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/6/23.
//

import SwiftUI

/// Make delay loading of the resource until the view is on screen
///
public struct LazyView<Content: View>: View {
    private let build: () -> Content
    
    public init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    
    public var body: Content {
        build()
    }
}
