//
//  CitiesService.swift
//  Globe Us
//
//  Created by Karim on 28.02.2021.
//

import Foundation

class CitiesService {
    private static let factory = RequestFactory()
    private static var mainFactory: MainRequestFactory?
    
    static func getAllClouds(with cityName: String, completion: @escaping (Result<CityResponse, Error>) -> Void) {
        mainFactory = factory.makeMainFactory()
        mainFactory?.getAllClouds(with: cityName, completion: { (result) in
            completion(result)
        })
    }
    
    static func getCities(countryId: Int, completion: @escaping (Result<CitiesResponse, Error>) -> Void) {
        mainFactory = factory.makeMainFactory()
        mainFactory?.getCities(countryId: countryId, completion: { (result) in
            completion(result)
        })
    }
}
