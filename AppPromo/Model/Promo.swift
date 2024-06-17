//
//  Promo.swift
//  AppPromo
//
//  Created by admin on 6/17/24.
//

import Foundation

struct Promo: Codable {
    let id: Int
    let name: String
    let imagesURL: String
    let detail: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imagesURL = "images_url"
        case detail
    }
}

struct PromoResponse: Codable {
    let promos: [Promo]
}
