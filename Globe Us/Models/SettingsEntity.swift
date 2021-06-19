//
//  SettingsResponse.swift
//  Globe Us
//
//  Created by Михаил Беленко on 13.06.2021.
//

import Foundation
import RealmSwift

class SettingsEntity: Object {
    @objc dynamic var countryId: Int = 6
    dynamic var loadedCitiesId = List<LoadedCityEntity>()
    @objc dynamic var mainScreenApp: MainScreenApp = MainScreenApp.photocamera
}

@objc enum MainScreenApp: Int, RealmEnum, CaseIterable {
    case photocamera, gallery
    
    var description: String {
        switch self {
        case .photocamera:
            return "Фотокамера"
        case .gallery:
            return "Галерея"
        }
    }
}
