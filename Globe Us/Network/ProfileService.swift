//
//  ProfileService.swift
//  Globe Us
//
//  Created by Михаил Беленко on 12.06.2021.
//

import Foundation

class ProfileService {
    
    static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter
    }
    
    static var demoProfile = ProfileFullResponse(status: "200", message: "Success", data:
                                                    ProfileResponse(photoURL: "https://www.traveller.com.au/content/dam/images/h/0/z/6/5/e/image.related.articleLeadwide.620x349.h10di4.png/1526953067684.jpg",
                                                                     firstName: "Соня",
                                                                     lastName: "Мармеладова",
                                                                     gender: .female,
                                                                     homeCity: "Москва",
                                                                     birthday: dateFormatter.date(from: "13.04.2000") ?? Date(),
                                                                     subscription: "Подписка S Pack активна",
                                                                     countPhoto: 15,
                                                                     rating: 8.9,
                                                                     photos: [
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
                                                                                        "https://www.cia-france.ru/media/1560/paris-petite_720x500.jpg",
                                                                                        
                                                                                        
                                                                                        "https://photos.mandarinoriental.com/is/image/MandarinOriental/paris-2017-home?wid=2880&hei=1280&fmt=jpeg&crop=9,336,2699,1200&anchor=1358,936&qlt=75,0&fit=wrap&op_sharpen=0&resMode=sharp2&op_usm=0,0,0,0&iccEmbed=0&printRes=72",
                                                                                        "https://q-xx.bstatic.com/xdata/images/hotel/840x460/210768979.jpg?k=8c5a446976bf74a068d77c5e1dcf37158b9625883dd99ff46175fa6d263836e2&o=",
                                                                                        "https://digital.ihg.com/is/image/ihg/intercontinental-paris-4031206249-2x1?fit=fit,1&wid=2400&hei=1200&qlt=85,0&resMode=sharp2&op_usm=1.75,0.9,2,0",
                                                                                        "https://assets.hyatt.com/content/dam/hyatt/hyattdam/images/2018/01/31/1045/Park-Hyatt-Paris-Vendome-P994-Paris-Place-Vendome.jpg/Park-Hyatt-Paris-Vendome-P994-Paris-Place-Vendome.16x9.jpg?imwidth=1920",
                                                                                        "https://cdn.odysseytraveller.com/app/uploads/2020/04/Paris.jpg",
                                                                                        "https://smapse.ru/storage/2018/12/28575627-1815698398504572-7194212321863410395-n.jpg",
                                                                                        "https://i0.wp.com/www.agoda.com/wp-content/uploads/2019/05/Marais-Paris-Notre-Dame-Cathedral.jpg",
                                                                                        "https://www.cia-france.ru/media/1560/paris-petite_720x500.jpg",
                                                                                        "https://photos.mandarinoriental.com/is/image/MandarinOriental/paris-2017-home?wid=2880&hei=1280&fmt=jpeg&crop=9,336,2699,1200&anchor=1358,936&qlt=75,0&fit=wrap&op_sharpen=0&resMode=sharp2&op_usm=0,0,0,0&iccEmbed=0&printRes=72",
                                                                                        "https://q-xx.bstatic.com/xdata/images/hotel/840x460/210768979.jpg?k=8c5a446976bf74a068d77c5e1dcf37158b9625883dd99ff46175fa6d263836e2&o=",
                                                                                        "https://digital.ihg.com/is/image/ihg/intercontinental-paris-4031206249-2x1?fit=fit,1&wid=2400&hei=1200&qlt=85,0&resMode=sharp2&op_usm=1.75,0.9,2,0",
                                                                                        "https://assets.hyatt.com/content/dam/hyatt/hyattdam/images/2018/01/31/1045/Park-Hyatt-Paris-Vendome-P994-Paris-Place-Vendome.jpg/Park-Hyatt-Paris-Vendome-P994-Paris-Place-Vendome.16x9.jpg?imwidth=1920",
                                                                                        "https://cdn.odysseytraveller.com/app/uploads/2020/04/Paris.jpg",
                                                                                        "https://smapse.ru/storage/2018/12/28575627-1815698398504572-7194212321863410395-n.jpg",
                                                                                        "https://i0.wp.com/www.agoda.com/wp-content/uploads/2019/05/Marais-Paris-Notre-Dame-Cathedral.jpg",
                                                                                        "https://www.cia-france.ru/media/1560/paris-petite_720x500.jpg",
                                                                                        "https://photos.mandarinoriental.com/is/image/MandarinOriental/paris-2017-home?wid=2880&hei=1280&fmt=jpeg&crop=9,336,2699,1200&anchor=1358,936&qlt=75,0&fit=wrap&op_sharpen=0&resMode=sharp2&op_usm=0,0,0,0&iccEmbed=0&printRes=72",
                                                                                        "https://q-xx.bstatic.com/xdata/images/hotel/840x460/210768979.jpg?k=8c5a446976bf74a068d77c5e1dcf37158b9625883dd99ff46175fa6d263836e2&o=",
                                                                                        "https://digital.ihg.com/is/image/ihg/intercontinental-paris-4031206249-2x1?fit=fit,1&wid=2400&hei=1200&qlt=85,0&resMode=sharp2&op_usm=1.75,0.9,2,0",
                                                                                        "https://assets.hyatt.com/content/dam/hyatt/hyattdam/images/2018/01/31/1045/Park-Hyatt-Paris-Vendome-P994-Paris-Place-Vendome.jpg/Park-Hyatt-Paris-Vendome-P994-Paris-Place-Vendome.16x9.jpg?imwidth=1920",
                                                                                        "https://cdn.odysseytraveller.com/app/uploads/2020/04/Paris.jpg",
                                                                                        "https://smapse.ru/storage/2018/12/28575627-1815698398504572-7194212321863410395-n.jpg",
                                                                                        "https://i0.wp.com/www.agoda.com/wp-content/uploads/2019/05/Marais-Paris-Notre-Dame-Cathedral.jpg",
                                                                                        "https://www.cia-france.ru/media/1560/paris-petite_720x500.jpg",
                                                                                        "https://photos.mandarinoriental.com/is/image/MandarinOriental/paris-2017-home?wid=2880&hei=1280&fmt=jpeg&crop=9,336,2699,1200&anchor=1358,936&qlt=75,0&fit=wrap&op_sharpen=0&resMode=sharp2&op_usm=0,0,0,0&iccEmbed=0&printRes=72",
                                                                                        "https://q-xx.bstatic.com/xdata/images/hotel/840x460/210768979.jpg?k=8c5a446976bf74a068d77c5e1dcf37158b9625883dd99ff46175fa6d263836e2&o=",
                                                                                        "https://digital.ihg.com/is/image/ihg/intercontinental-paris-4031206249-2x1?fit=fit,1&wid=2400&hei=1200&qlt=85,0&resMode=sharp2&op_usm=1.75,0.9,2,0",
                                                                                        "https://assets.hyatt.com/content/dam/hyatt/hyattdam/images/2018/01/31/1045/Park-Hyatt-Paris-Vendome-P994-Paris-Place-Vendome.jpg/Park-Hyatt-Paris-Vendome-P994-Paris-Place-Vendome.16x9.jpg?imwidth=1920",
                                                                                        "https://cdn.odysseytraveller.com/app/uploads/2020/04/Paris.jpg",
                                                                                        "https://smapse.ru/storage/2018/12/28575627-1815698398504572-7194212321863410395-n.jpg",
                                                                                        "https://i0.wp.com/www.agoda.com/wp-content/uploads/2019/05/Marais-Paris-Notre-Dame-Cathedral.jpg",
                                                                                        "https://www.cia-france.ru/media/1560/paris-petite_720x500.jpg"
                                                                                     ])
                                                                     ]))
    
    static func getProfile(completion: @escaping (Result<ProfileFullResponse, Error>) -> Void) {
        completion(.success(demoProfile))
    }
    
    static func changeProfile(firstName: String, lastName: String, gender: Int, homeCity: String, birthday: String) {
        demoProfile.data.firstName = firstName
        demoProfile.data.lastName = lastName
        demoProfile.data.gender = Gender(rawValue: gender) ?? .male
        demoProfile.data.homeCity = homeCity
        demoProfile.data.birthday = dateFormatter.date(from: birthday) ?? Date()
    }
}
