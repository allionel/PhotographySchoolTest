//
//  DependencyContainer.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/2/23.
//

import Foundation

final class DependencyContainer: Singleton {
    public static var shared: DependencyContainer = .init()
    private init() {}

    private(set) lazy var services = ServicesDependencyContainer()
}
