//
//  LoadedCityEntity.swift
//  Globe Us
//
//  Created by Михаил Беленко on 18.06.2021.
//

import RealmSwift

class LoadedCityEntity: Object {
    @objc dynamic var countryId: Int = 0
    dynamic var loadedCitiesId = List<Int>()
}
