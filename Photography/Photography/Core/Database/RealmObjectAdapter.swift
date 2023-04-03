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
    var pk: String { get } // Returns primaryKey
}

public extension RealmUniqueObject {
    var pk: String {
        return value(forKey: Self.primaryKey() ?? "") as? String ?? ""
    }
}
