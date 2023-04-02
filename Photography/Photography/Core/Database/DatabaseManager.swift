//
//  DatabaseManager.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/3/23.
//

import Foundation
import RealmSwift

public final class DatabaseManager: Singleton {
    public static let shared: DatabaseManager = .init()
    private init() { }

    private var realm: Realm? {
        return try? Realm()
    }
}

extension DatabaseManager: DatabaseProvider {
    public var fileURL: URL? {
        return realm?.configuration.fileURL
    }

    public func save<T>(_ object: T) where T: RealObjectAdapter {
        do {
            let realm = try Realm()
            try realm.write({
                realm.add(object.managedObject(), update: .all)
            })
        } catch {
            log(error: error)
        }
    }

    public func load<T>() -> [T] where T: RealObjectAdapter {
        do {
            let realm = try Realm()
            let managedObjects = realm.objects(T.ManagedObject.self)
            return managedObjects.map(T.init(managedObject:))
        } catch {
            log(error: error)
            return []
        }
    }

    @discardableResult
    public func delete<T>(_ object: T) -> T where T: RealObjectAdapter {
        do {
            let realm = try Realm()
            let managedObject = realm.objects(T.ManagedObject.self).filter({
                $0.pk == object.managedObject().pk
            })
            try realm.write {
                realm.delete(managedObject)
            }
            return object
        } catch {
            log(error: error)
            return object
        }
    }

    private func log(error: Error) {
        #if DEBUG
        print("@Relam_Error", error.localizedDescription)
        #endif
    }
}
