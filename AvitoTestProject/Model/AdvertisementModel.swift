//
//  AdvertisementModel.swift
//  AvitoTestProject
//
//  Created by Александра Маслова on 27.08.2023.
//

import Foundation

struct AdvertisementCollection: Codable {
    var advertisements: [Advertisement]
}

class Advertisement: Codable {
    let id: String
    let title: String
    let price: String
    let location: String
    let imageURL: URL
    let createdDate: String
    var description: String?
    var email: String?
    var phoneNumber: String?
    var address: String?
    var isFavorite: Bool
    
    private enum Keys: String, CodingKey {
        case id, title, price, location, description, email, address
        case imageURL = "image_url"
        case createdDate = "created_date"
        case phoneNumber = "phone_number"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        price = try container.decode(String.self, forKey: .price)
        location = try container.decode(String.self, forKey: .location)
        imageURL = try container.decode(URL.self, forKey: .imageURL)
        createdDate = try container.decode(String.self, forKey: .createdDate)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        email = try container.decodeIfPresent(String.self, forKey: .email)
        phoneNumber = try container.decodeIfPresent(String.self, forKey: .phoneNumber)
        address = try container.decodeIfPresent(String.self, forKey: .address)
        isFavorite = false
    }
}

struct Advertisements: Codable {
    let advertisements: [Advertisement]
}
