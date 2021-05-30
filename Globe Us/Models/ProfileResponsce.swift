//
//  ProfileResponsce.swift
//  Globe Us
//
//  Created by Михаил Беленко on 29.05.2021.
//

import Foundation

struct ProfileFullResponse: Codable {
    let status: String
    let message: String?
    var data: ProfileResponsce
}

struct ProfileResponsce: Codable {
    let photoURL: String
    let firstName: String
    let lastName: String
    let subscription: String
    let countPhoto: Int
    let rating: Float
    var photos: [PhotosEntity]
}

struct PhotosEntity: Codable {
    let city: String
    var photosURL: [String]
}
