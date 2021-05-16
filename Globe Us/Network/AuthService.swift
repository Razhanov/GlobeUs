//
//  AuthService.swift
//  Globe Us
//
//  Created by Михаил Беленко on 15.05.2021.
//

import Foundation

class AuthService {
    private static let factory = RequestFactory()
    private static var mainFactory: MainRequestFactory?
    
    static func login(email: String, password: String, completion: @escaping (Result<AuthFullResponse, Error>) -> Void) {
        mainFactory = factory.makeMainFactory()
        mainFactory?.login(email: email, password: password, completion: { (result) in
            completion(result)
        })
    }
    
    static func register(email: String, password: String, completion: @escaping (Result<RegisterFullResponse, Error>) -> Void) {
        mainFactory = factory.makeMainFactory()
        mainFactory?.register(email: email, password: password, completion: { (result) in
            completion(result)
        })
    }
    
    static func signInGoogle(userId: String, completion: @escaping (Result<AuthFullResponse, Error>) -> Void) {
        mainFactory = factory.makeMainFactory()
        mainFactory?.signInGoogle(userId: userId, completion: { (result) in
            completion(result)
        })
    }

    
    static func signInApple(userId: String, completion: @escaping (Result<AuthFullResponse, Error>) -> Void) {
        mainFactory = factory.makeMainFactory()
        mainFactory?.signInApple(userId: userId, completion: { (result) in
            completion(result)
        })
    }
    
    static func signInFacebook(userId: String, completion: @escaping (Result<AuthFullResponse, Error>) -> Void) {
        mainFactory = factory.makeMainFactory()
        mainFactory?.signInFacebook(userId: userId, completion: { (result) in
            completion(result)
        })
    }
}
