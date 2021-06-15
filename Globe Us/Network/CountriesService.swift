//
//  CountriesService.swift
//  Globe Us
//
//  Created by Михаил Беленко on 13.06.2021.
//

import Foundation

class CountriesService {
    private static let factory = RequestFactory()
    private static var mainFactory: MainRequestFactory?
    
    static func getCountries(langId: Int, completion: @escaping (Result<CountriesResponse, Error>) -> Void) {
        mainFactory = factory.makeMainFactory()
        mainFactory?.getCountries(langId: langId, completion: { (result) in
            completion(result)
        })
    }
}
