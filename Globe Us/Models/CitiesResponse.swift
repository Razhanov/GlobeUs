//
//  CitiesResponse.swift
//  Globe Us
//
//  Created by Karim on 28.02.2021.
//

import Foundation

struct CitiesResponse: Codable {
    let status: String
    let message: String?
    let data: [City]
    
    enum CodingKeys: String, CodingKey {
        case status,
             message,
             data
    }
}

struct CityResponse: Codable {
    let status: String
    let message: String?
    let data: CityData
    
    enum CodingKeys: String, CodingKey {
        case status,
             message,
             data
    }
}

struct CityData: Codable {
    let city: City?
    let place: [Place]?
    
    enum CodingKeys: String, CodingKey {
        case city, place
    }
}

struct City: Codable {
    let id: Int
    let title: String
    let images: [String?]
    let places: [Place]?
    let clouds: [CloudData]?
    
    enum CodingKeys: String, CodingKey {
        case id,
             title,
             images,
             clouds
        case places = "Places"
    }
}

struct Place: Codable {
    let id: Int
    let title: String
    let images: [String]
    let description: String
    let clouds: [CloudData]?
    
    enum CodingKeys: String, CodingKey {
        case id,
             title,
             images,
             description,
             clouds
    }
}

struct CloudData: Codable {
    let id: Int
    let title: String
    let topImage, bottomImage, squareImage: String
    let isFree: Bool
    
    enum CodingKeys: String, CodingKey {
        case id,
             title,
             isFree
        case topImage = "top"
        case bottomImage = "bottom"
        case squareImage = "square"
    }
}
