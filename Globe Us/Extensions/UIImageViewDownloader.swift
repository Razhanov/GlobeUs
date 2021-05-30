//
//  UIImageViewDownloader.swift
//  Globe Us
//
//  Created by Karim on 28.02.2021.
//

import Foundation
import Alamofire
import AlamofireImage

let imageCache = AutoPurgingImageCache(memoryCapacity: 100_000_000, preferredMemoryUsageAfterPurge: 60_000_000)

extension UIImageView {
    
    /// Synchronous image loading
    ///
    /// - Parameter url: image url
    func load(url: URL) {
        if let data = try? Data(contentsOf: url) {
            if let image = UIImage(data: data) {
                self.image = image
            }
        }
    }
    
    /// Asynchronous image loading
    ///
    /// - Parameters:
    ///   - url: image url
    ///   - completion: code executed after image loading
    func loadWithAlamofire(urlString: String, placeholderImage: UIImage = UIImage(imageLiteralResourceName: "demo_image"), completion: @escaping () -> Void = {}) {
        if let cachedImage = imageCache.image(withIdentifier: urlString) {
            self.image = cachedImage
        } else {
            self.image = placeholderImage
            AF.request("https://selfident.ompr.io/api/" + urlString).responseImage { (response) in
                if let imageUrl = response.value {
                    self.image = imageUrl
                    imageCache.add(imageUrl, withIdentifier: urlString)
                    completion()
                } else {
                    self.image = placeholderImage
                }
            }
        }
    }
    
    /// - Parameters:
    ///   - fullUrl: image url
    ///   - completion: code executed after image loading
    func loadWithAlamofire(urlStringFull: String, placeholderImage: UIImage = UIImage(imageLiteralResourceName: "demo_image"), completion: @escaping () -> Void = {}) {
        if let cachedImage = imageCache.image(withIdentifier: urlStringFull) {
            self.image = cachedImage
        } else {
            self.image = placeholderImage
            AF.request(urlStringFull).responseImage { (response) in
                if let imageUrl = response.value {
                    self.image = imageUrl
                    imageCache.add(imageUrl, withIdentifier: urlStringFull)
                    completion()
                } else {
                    self.image = placeholderImage
                }
            }
        }
    }
}
