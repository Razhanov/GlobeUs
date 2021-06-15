//
//  CountriesResponse.swift
//  Globe Us
//
//  Created by Михаил Беленко on 13.06.2021.
//

import Foundation

struct CountriesResponse: Codable {
    let status: String
    let message: String?
    let data: [CountryResponse]
    
    enum CodingKeys: String, CodingKey {
        case status,
             message,
             data
    }
}

struct CountryResponse: Codable {
    let id: Int
    let title: String
    let cities: [City]
    
    enum CodingKeys: String, CodingKey {
        case id,
             title
        case cities = "Cities"
    }
}
