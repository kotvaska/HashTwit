//
// Created by Anastasia Zolotykh on 10.03.2018.
// Copyright (c) 2018 kotvaska. All rights reserved.
//

import Foundation

struct Status: Codable {

    let statuses: [Tweet]

    enum TopCodingKeys: String, CodingKey {
        case statuses
    }

}

struct Tweet: Codable, Hashable, Equatable {

    let id: Int
    let text: String
    let author: User
    let createdAt: String
    let media: String?

    enum CodingKeys: String, CodingKey {
        case id
        case text
        case createdAt = "created_at"
        case user
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        text = try values.decode(String.self, forKey: .text)
        createdAt = try values.decode(String.self, forKey: .createdAt)
        author = try values.decode(User.self, forKey: .user)
        media = nil
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(text, forKey: .text)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(author, forKey: .user)
    }

    var hashValue: Int {
        return id
    }

    static func ==(left: Tweet, right: Tweet) -> Bool {
        return left.id == right.id
    }

}

struct User: Codable {
    let name: String
    let nickName: String

    enum CodingKeys: String, CodingKey {
        case name
        case nickName = "screen_name"
    }

}
