//
//  DependencyContainer.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/2/23.
//

import Foundation

final class DependencyContainer {
    static var shared = DependencyContainer()
    private init() {}

    private(set) lazy var services = ServicesDependencyContainer()
}
