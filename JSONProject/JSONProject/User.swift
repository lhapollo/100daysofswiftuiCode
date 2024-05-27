//
//  User.swift
//  JSONProject
//
//  Created by Lexi Han on 2024-05-27.
//

import Foundation

struct User: Codable, Identifiable {
    let id: String
    let name: String
    let age: Int
    let company: String
    let isActive: Bool
    let address: String
    let email: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
}

struct Friend: Codable, Identifiable {
    let id: String
    let name: String
}
