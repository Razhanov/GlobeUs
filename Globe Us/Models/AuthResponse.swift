//
//  AuthResponse.swift
//  Globe Us
//
//  Created by Михаил Беленко on 15.05.2021.
//

import Foundation

struct AuthFullResponse: Codable {
    let status: String
    let message: String?
    let data: AuthResponse
}

struct AuthResponse: Codable {
    let accessToken: String
    let refreshToken: String
}
