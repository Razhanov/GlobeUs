//
//  SettingsService.swift
//  Globe Us
//
//  Created by Михаил Беленко on 14.06.2021.
//

import Foundation

final class SettingsService {
    static let shared = SettingsService()
    
    let settings: SettingsEntity
    
    private init() {
        if let realm = RealmService.shared.realm {
            let settingsArray = Array(realm.objects(SettingsEntity.self))
            if let firstSettings = settingsArray.first {
                settings = firstSettings
            } else {
                do {
                    let settings = SettingsEntity()
                    try realm.write {
                        realm.add(settings)
                    }
                    self.settings = settings
                } catch let error {
                    #if DEBUG
                    fatalError(error.localizedDescription)
                    #else
                    print(error.localizedDescription)
                    #endif
                }
            }
        } else {
            settings = SettingsEntity()
        }
    }
    
    func applySettings(countryId: Int, mainScreenAppRawValue: Int) {
        do {
            try RealmService.shared.realm?.write {
                settings.countryId = countryId
                settings.mainScreenApp = MainScreenApp(rawValue: mainScreenAppRawValue) ?? .photocamera
            }
        } catch let error {
            #if DEBUG
            fatalError(error.localizedDescription)
            #else
            print(error.localizedDescription)
            #endif
        }
    }
}