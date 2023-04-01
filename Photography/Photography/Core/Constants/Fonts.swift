//
//  Fonts.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/1/23.
//

import SwiftUI

/// Fonts colors to use in SwiftUI
///
public extension Font {
    static var title1: Font {
        .system(Font.TextStyle.title, design: .default, weight: .bold)
    }
    
    static var subtitle: Font {
        .system(Font.TextStyle.body, design: .default, weight: .medium)
    }
    
    static var regularBody: Font {
        .system(Font.TextStyle.body, design: .default, weight: .medium)
    }
}

/// Fonts colors to use in UIKit
///
public extension UIFont {
    static var title1: UIFont {
        .systemFont(ofSize: UIFont.preferredFont(forTextStyle: .title1).pointSize, weight: .bold)
    }
    
    static var subtitle: UIFont {
        .systemFont(ofSize: UIFont.preferredFont(forTextStyle: .title3).pointSize, weight: .medium)
    }
    
    static var regularBody: UIFont {
        .systemFont(ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize, weight: .medium)
    }
}
