//
//  LessonRealmObject.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/3/23.
//

import Foundation
import RealmSwift

public final class LessonRealmObject: Object, RealmUniqueObject {
    @Persisted(primaryKey: true) public dynamic var id: Int = -1
    @Persisted public dynamic var name: String = ""
    @Persisted public dynamic var desc: String = ""
    @Persisted public dynamic var thumbnail: String = ""
    @Persisted public dynamic var videoUrl: String = ""
    @Persisted public dynamic var thumbnailLocalPath: String = ""
    @Persisted public dynamic var videoLocalPath: String = ""

    public override static func primaryKey() -> String? {
        return "id"
    }
}
