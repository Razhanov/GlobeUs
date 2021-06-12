//
//  ProfileResponse.swift
//  Globe Us
//
//  Created by Михаил Беленко on 29.05.2021.
//

import Foundation

struct ProfileFullResponse: Codable {
    let status: String
    let message: String?
    var data: ProfileResponse
}

struct ProfileResponse: Codable {
    let photoURL: String
    var firstName: String
    var lastName: String
    var gender: Gender
    var homeCity: String
    var birthday: Date
    let subscription: String
    let countPhoto: Int
    let rating: Float
    var photos: [PhotosEntity]
}

enum Gender: Int, Codable, CaseIterable {
    case male, female
    
    var description: String {
        switch self {
        case .male:
            return "Мужской"
        case .female:
            return "Женский"
        }
    }
}

struct PhotosEntity: Codable {
    let city: String
    var photosURL: [String]
}
