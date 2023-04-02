//
//  LessonRealmObject.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/3/23.
//

import Foundation
import RealmSwift

public final class LessonRealmObject: Object, RealmUniqueObject {
    @objc public dynamic var id: Int = -1
    @objc public dynamic var name: String = ""
    @objc public dynamic var desc: String = ""
    @objc public dynamic var thumbnail: String = ""
    @objc public dynamic var videoUrl: String = ""
    
    public override static func primaryKey() -> String? {
        return "id"
    }
}
