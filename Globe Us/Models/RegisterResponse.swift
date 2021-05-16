//
//  RegisterResponse.swift
//  Globe Us
//
//  Created by Михаил Беленко on 16.05.2021.
//

import Foundation

struct RegisterFullResponse: Codable {
    let status: String
    let message: String?
    let data: RegisterResponse
}

struct RegisterResponse: Codable {
    let email: String
}
