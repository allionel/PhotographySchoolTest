//
//  DatabaseProvider.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/3/23.
//

import Foundation
import RealmSwift

public protocol DatabaseProvider {
    // Returns path to database or configuration file
    var fileURL: URL? { get }

    func save<T: RealObjectAdapter>(_ object: T)

    func load<T: RealObjectAdapter>() -> [T]

    @discardableResult
    func delete<T: RealObjectAdapter>(_ object: T) -> T
}

