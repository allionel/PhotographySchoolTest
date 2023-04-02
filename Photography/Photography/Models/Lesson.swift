//
//  Lesson.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/2/23.
//

import Foundation

public struct Lessons: Codable {
    public let lessons: [Lessons]
}

public struct Lesson: Codable, Identifiable, Hashable {
    public let id: Int
    public let name: String
    public let description: String
    public let thumbnail: String
    public let videoUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case id, name, description, thumbnail
        case videoUrl = "video_url"
    }
}

extension Lesson: RealObjectAdapter {
    public init(managedObject: LessonRealmObject) {
        self.id = managedObject.id
        self.name = managedObject.name
        self.description = managedObject.desc
        self.thumbnail = managedObject.thumbnail
        self.videoUrl = managedObject.videoUrl
    }

    public func managedObject() -> LessonRealmObject {
        let managedObject: LessonRealmObject = .init()
        managedObject.id = id
        managedObject.name = name
        managedObject.desc = description
        managedObject.thumbnail = thumbnail
        managedObject.videoUrl = videoUrl
        return managedObject
    }
}
