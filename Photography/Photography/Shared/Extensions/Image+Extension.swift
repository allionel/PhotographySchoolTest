//
//  Image+Extension.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/1/23.
//

import SwiftUI

public extension Image {
    init(name: ImageName) {
        self.init(name.rawValue)
    }
}

public struct ImageName: ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    public var rawValue: String
    
    public init(stringLiteral value: String) {
        rawValue = value
    }
}
