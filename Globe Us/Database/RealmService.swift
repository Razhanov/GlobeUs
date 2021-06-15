//
//  RealmService.swift
//  Globe Us
//
//  Created by Михаил Беленко on 14.06.2021.
//

import Foundation
import RealmSwift

final class RealmService {
    static let shared = RealmService()
    
    let realm: Realm?
    
    private init() {
        do {
            realm = try Realm()
        } catch let error {
            #if DEBUG
            fatalError(error.localizedDescription)
            #else
            print(error.localizedDescription)
            #endif
        }
    }
}
