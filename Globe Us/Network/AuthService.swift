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
    
    static func signInWithGoogle(userId: String, completion: @escaping (Result<AuthFullResponse, Error>) -> Void) {
        mainFactory = factory.makeMainFactory()
        mainFactory?.signInWithGoogle(userId: userId, completion: { (result) in
            completion(result)
        })
    }

    
    static func signInWithApple(userId: String, completion: @escaping (Result<AuthFullResponse, Error>) -> Void) {
        mainFactory = factory.makeMainFactory()
        mainFactory?.signInWithApple(userId: userId, completion: { (result) in
            completion(result)
        })
    }
    
    static func signInWithFacebook(userId: String, completion: @escaping (Result<AuthFullResponse, Error>) -> Void) {
        mainFactory = factory.makeMainFactory()
        mainFactory?.signInWithFacebook(userId: userId, completion: { (result) in
            completion(result)
        })
    }
}
