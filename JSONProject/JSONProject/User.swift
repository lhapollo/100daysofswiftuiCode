//
//  User.swift
//  JSONProject
//
//  Created by Lexi Han on 2024-05-27.
//

import Foundation
import SwiftData

@Model
class User: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case age
        case company
        case isActive
        case address
        case email
        case about
        case registered
        case tags
        case friends
    }
    
    var id: String
    var name: String
    var age: Int
    var company: String
    var isActive: Bool
    var address: String
    var email: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.age = try container.decode(Int.self, forKey: .age)
        self.company = try container.decode(String.self, forKey: .company)
        self.isActive = try container.decode(Bool.self, forKey: .isActive)
        self.address = try container.decode(String.self, forKey: .address)
        self.email = try container.decode(String.self, forKey: .email)
        self.about = try container.decode(String.self, forKey: .about)
        self.registered = try container.decode(Date.self, forKey: .registered)
        self.tags = try container.decode([String].self, forKey: .tags)
        self.friends = try container.decode([Friend].self, forKey: .friends)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(age, forKey: .age)
        try container.encode(company, forKey: .company)
        try container.encode(isActive, forKey: .isActive)
        try container.encode(address, forKey: .address)
        try container.encode(email, forKey: .email)
        try container.encode(about, forKey: .about)
        try container.encode(registered, forKey: .registered)
        try container.encode(tags, forKey: .tags)
        try container.encode(friends, forKey: .friends)
    }
}

@Model
class Friend: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    var id: String
    var name: String

    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }
}
