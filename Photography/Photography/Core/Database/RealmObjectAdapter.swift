//
//  RealObjectAdapter.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/3/23.
//

import Foundation
import RealmSwift

public protocol RealmObjectAdapter {
    associatedtype ManagedObject: RealmSwift.Object & RealmUniqueObject
    init(managedObject: ManagedObject)
    func managedObject() -> ManagedObject
}

public protocol RealmUniqueObject: Object {
    // Returns primaryKey
    var pk: String { get }
}

public extension RealmUniqueObject {
    var pk: String {
        return value(forKey: Self.primaryKey() ?? "") as? String ?? ""
    }
}
