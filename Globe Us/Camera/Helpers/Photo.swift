//
// Created by Karim on 28.02.2021.
//

import Foundation
import UIKit

public class Photo: Hashable {

    public var image: UIImage!
    public let url: URL!
    public let id = UUID()

    public init(image: UIImage, url: URL) {
        self.image = image
        self.url = url
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public static func == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.id == rhs.id
    }

    public static let static_photo = Photo(image: UIImage(named: "widget-image")!, url: URL(fileURLWithPath: "static_photo_url"))
}