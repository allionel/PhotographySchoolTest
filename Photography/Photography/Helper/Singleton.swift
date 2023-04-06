//
//  Singleton.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/3/23.
//

import Foundation

public protocol Singleton {
    static var shared: Self { get }
}
