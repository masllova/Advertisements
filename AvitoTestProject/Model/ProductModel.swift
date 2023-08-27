//
//  ProductModel.swift
//  AvitoTestProject
//
//  Created by Александра Маслова on 27.08.2023.
//

import Foundation

struct Product {
    let id: String
    let title: String
    let price: String
    let location: String
    let imageURL: URL
    let createdDate: String
    let description: String?
    let email: String?
    let phoneNumber: String?
    let address: String?
}

enum Keys: String, CodingKey {
    case id, title, price, location, description, email, address
    case imageURL = "image_url"
    case createdDate = "created_date"
    case phoneNumber = "phone_number"
}
