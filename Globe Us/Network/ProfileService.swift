//
//  ProfileService.swift
//  Globe Us
//
//  Created by Михаил Беленко on 12.06.2021.
//

import Foundation

class ProfileService {
    
    private static let factory = RequestFactory()
    private static var mainFactory: MainRequestFactory?
    
    static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter
    }
    
    static func getProfile(completion: @escaping (Result<ProfileFullResponse, Error>) -> Void) {
        mainFactory = factory.makeMainFactory()
        
        mainFactory?.getProfile(completion: completion)
    }
    
    static func changeProfile(firstName: String, lastName: String, gender: Int, targetPlace: String, birthday: String, completion: @escaping (Result<Void, Error>) -> Void) {
        mainFactory = factory.makeMainFactory()
        
        mainFactory?.updateProfile(firstName: firstName, lastName: lastName, birthday: birthday, targetPlace: targetPlace, photoUrl: nil, email: nil, completion: completion)
    }
    
    static func changePassword(oldPassword: String, newPassword: String, completion: @escaping (Result<Void, Error>) -> Void) {
        completion(.success(()))
    }
}
