//
//  ProfileResponse.swift
//  Globe Us
//
//  Created by Михаил Беленко on 29.05.2021.
//

import Foundation

struct ProfileFullResponse: Codable {
    let status: String
    let message: String?
    var data: ProfileResponse
}

struct ProfileResponse: Codable {
    let photoURL: String
    var firstName: String
    var lastName: String
    var gender: Gender
    var targetPlace: String
    var birthday: Date
    let subscription: String
    let rating: Float
    var photos: [PhotosEntity]
    
    var countPhoto: Int {
        photos.reduce(0, { $0 + $1.photosURL.count })
    }
    
    enum CodingKeys: String, CodingKey {
        case gender, subscription, rating, photos
        case photoURL = "photo"
        case firstName = "firstname"
        case lastName = "lastname"
        case targetPlace = "targetPlace"
        case birthday = "birthday"
    }
    
    init(from decoder: Decoder) throws {
        let decoder = try decoder.container(keyedBy: CodingKeys.self)
        
        photoURL = try decoder.decode(String.self, forKey: .photoURL)
        firstName = try decoder.decode(String.self, forKey: .firstName)
        lastName = try decoder.decode(String.self, forKey: .lastName)
        targetPlace = try decoder.decode(String.self, forKey: .targetPlace)
        
        let birthdayString = try decoder.decode(String.self, forKey: .birthday)
        birthday = ProfileService.dateFormatter.date(from: birthdayString) ?? Date()
        
        if let gender = try? decoder.decode(Int.self, forKey: .gender) {
            self.gender = Gender(rawValue: gender) ?? .male
        } else {
            self.gender = .male
        }
        
        if let subscription = try? decoder.decode(String.self, forKey: .subscription) {
            self.subscription = subscription
        } else {
            self.subscription = "Подписка S Pack активна"
        }
        
        if let rating = try? decoder.decode(Float.self, forKey: .rating) {
            self.rating = rating
        } else {
            self.rating = 8.9
        }
        
        if let photos = try? decoder.decode([PhotosEntity].self, forKey: .photos) {
            self.photos = photos
        } else {
            self.photos =
                [
                    PhotosEntity(city: "Санкт-Петербург",
                                 photosURL: [
                                    "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f2/Hermitage_Museum_in_Saint_Petersburg.jpg/600px-Hermitage_Museum_in_Saint_Petersburg.jpg",
                                    "https://coworker.imgix.net/pictures/C171/edit/st-petersburg-resize.jpg?auto=format,compress&fit=clamp",
                                    "https://lh3.googleusercontent.com/proxy/XK8Ey-MycvF9d358yrsQ1JNC1xNXj-d11BKXri92-JZooJ-n-vs8shguwhxPZYgVS5R8_ra74oT1cI3-fMTlrlcY65ngTXQL_cKbJIcEaSeqwv5gC5EGM3HsJSF7svKNQWMTi87RY3xvGYFLIr3yCMCIdp4EFT5K9g",
                                    "https://tripsget.com/wp-content/uploads/2019/04/28021197423_7c8bcc77cc_k.jpg",
                                    "https://stingynomads.com/wp-content/uploads/2019/02/Kazan-cathedral-St-Petersburg-things-to-do.jpg",
                                    "https://anotherrussia.com/upload/medialibrary/ff9/moscow-saint-petersburg-1.jpg",
                                    "https://cdni.rbth.com/rbthmedia/images/2017.10/original/59ea012015e9f9176f1b160f.jpg"
                                 ]),
                    PhotosEntity(city: "Париж",
                                 photosURL: [
                                    "https://photos.mandarinoriental.com/is/image/MandarinOriental/paris-2017-home?wid=2880&hei=1280&fmt=jpeg&crop=9,336,2699,1200&anchor=1358,936&qlt=75,0&fit=wrap&op_sharpen=0&resMode=sharp2&op_usm=0,0,0,0&iccEmbed=0&printRes=72",
                                    "https://q-xx.bstatic.com/xdata/images/hotel/840x460/210768979.jpg?k=8c5a446976bf74a068d77c5e1dcf37158b9625883dd99ff46175fa6d263836e2&o=",
                                    "https://digital.ihg.com/is/image/ihg/intercontinental-paris-4031206249-2x1?fit=fit,1&wid=2400&hei=1200&qlt=85,0&resMode=sharp2&op_usm=1.75,0.9,2,0",
                                    "https://assets.hyatt.com/content/dam/hyatt/hyattdam/images/2018/01/31/1045/Park-Hyatt-Paris-Vendome-P994-Paris-Place-Vendome.jpg/Park-Hyatt-Paris-Vendome-P994-Paris-Place-Vendome.16x9.jpg?imwidth=1920",
                                    "https://cdn.odysseytraveller.com/app/uploads/2020/04/Paris.jpg",
                                    "https://smapse.ru/storage/2018/12/28575627-1815698398504572-7194212321863410395-n.jpg",
                                    "https://i0.wp.com/www.agoda.com/wp-content/uploads/2019/05/Marais-Paris-Notre-Dame-Cathedral.jpg",
                                    "https://www.cia-france.ru/media/1560/paris-petite_720x500.jpg"
                                 ])
                ]
        }
    }
}

enum Gender: Int, Codable, CaseIterable {
    case male, female
    
    var description: String {
        switch self {
        case .male:
            return "Мужской"
        case .female:
            return "Женский"
        }
    }
}

struct PhotosEntity: Codable {
    let city: String
    var photosURL: [String]
}
