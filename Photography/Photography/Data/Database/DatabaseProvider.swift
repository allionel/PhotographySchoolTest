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

    func save<T: RealmObjectAdapter>(_ object: T) throws

    func fetch<T: RealmObjectAdapter>() throws -> [T]

    @discardableResult
    func delete<T: RealmObjectAdapter>(_ object: T) throws -> T
}

