//
//  Colors.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/1/23.
//

import SwiftUI

/// Custom colors to use in SwiftUI
///
public extension Color {
    static var surface: Color {
        .init(hex: 0xD2D2D2)
    }
    
    static var caption: Color {
        .init(hex: 0xFFFFFF)
    }
    
    static var border: Color {
        .init(hex: 0x444444)
    }
    
    static var action: Color {
        .init(hex: 0x3064BC)
    }
    
    static var background: Color {
        .init(hex: 0x1C1C1C)
    }
}

/// Custom colors to use in UIKit
///
public extension UIColor {
    static var surface: UIColor {
        .init(.surface)
    }
    
    static var caption: UIColor {
        .init(.caption)
    }
    
    static var border: UIColor {
        .init(.border)
    }
    
    static var action: UIColor {
        .init(.action)
    }
    
    static var background: UIColor {
        .init(.background)
    }
}
