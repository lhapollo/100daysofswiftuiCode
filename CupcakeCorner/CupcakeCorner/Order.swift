//
//  Order.swift
//  CupcakeCorner
//
//  Created by Lexi Han on 2024-05-17.
//

import SwiftUI

@Observable
class Order: Codable, ObservableObject {
    static let types = ["Vanilla", "Strawberry", "Chocolate"]
    
    var type = 0
    var quantity = 3
    
    var name = "" {
        didSet {
            saveToUserDefaults()
        }
    }
    var streetAddress = "" {
        didSet {
            saveToUserDefaults()
        }
    }
    var city = "" {
        didSet {
            saveToUserDefaults()
        }
    }
    var zip = "" {
        didSet {
            saveToUserDefaults()
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var hasValidAddress: Bool {
        if name.trimmingCharacters(in: .whitespaces).isEmpty || streetAddress.trimmingCharacters(in: .whitespaces).isEmpty || city.trimmingCharacters(in: .whitespaces).isEmpty || zip.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }
        
        return true
    }
    
    var cost: Double {
        var cost = Double(quantity) * 2
        
        cost += (Double(type) / 2)
        
        if extraFrosting {
            cost += Double(quantity)
        }
        
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
    
    init() {
        loadFromUserDefaults()
    }
    
    func saveToUserDefaults() {
        UserDefaults.standard.set(name, forKey: "name")
        UserDefaults.standard.set(streetAddress, forKey: "streetAddress")
        UserDefaults.standard.set(city, forKey: "city")
        UserDefaults.standard.set(zip, forKey: "zip")
    }
    
    func loadFromUserDefaults() {
        name = UserDefaults.standard.string(forKey: "name") ?? ""
        streetAddress = UserDefaults.standard.string(forKey: "streetAddress") ?? ""
        city = UserDefaults.standard.string(forKey: "city") ?? ""
        zip = UserDefaults.standard.string(forKey: "zip") ?? ""
    }
}
