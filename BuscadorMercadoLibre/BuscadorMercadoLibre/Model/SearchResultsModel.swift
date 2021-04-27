//
//  SearchResultsModel.swift
//  BuscadorMercadoLibre
//
//  Created by Tobias Lewinzon on 25/04/2021.
//

import Foundation

/// Dictionary of response. Contains key "results", holding an array of items.
struct SearchResults: Codable {
    /// Holds an array of result Items.
    let results: [Item]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}

/// Model for a result Item. Contains all needed properties.
struct Item: Codable {
    let id: String
    let title: String
    let price: Double
    let availableQuantity: Int
    let soldQuantity: Int
    let condition: String
    let permalink: String
    let thumbnail: String
    let address: Address
    let shipping: Shipping
    
    enum CodingKeys: String, CodingKey {
        case id, title, price, condition, permalink, thumbnail, address, shipping
        case availableQuantity = "available_quantity"
        case soldQuantity = "sold_quantity"
    }
}

/// Struct for address information.
struct Address: Codable {
    let cityName: String
    
    enum CodingKeys: String, CodingKey {
        case cityName = "city_name"
    }
}

/// Struct for shipping information.
struct Shipping: Codable {
    let freeShipping: Bool
    let storePickup: Bool
    
    enum CodingKeys: String, CodingKey {
        case freeShipping = "free_shipping"
        case storePickup = "store_pick_up"
    }
}
