//
// Created by Karim on 28.02.2021.
//

import Foundation
import UIKit
import Photos

public struct DataEngine {

    public static let shared = DataEngine()
    private init() { }

    /// Save the image data to the device
    /// - Parameter imageData: "The image data ready to be saved"
    public func save(imageData: Data) {
//        let timestamp = NSDate().timeIntervalSince1970
//        let imageName = "GlobUs_\(timestamp).jpeg"

//        let fileManager = FileManager.default
//        let url = fileManager.containerURL(forSecurityApplicationGroupIdentifier: "group.com.razhanov.globus")?.appendingPathComponent(imageName)

        // store image in group container
//        fileManager.createFile(atPath: url!.path as String, contents: imageData, attributes: nil)
//        let image = UIImage(data: imageData)!
//        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)

        PHPhotoLibrary.requestAuthorization { (status) in
            guard status == .authorized else { return }
            PHPhotoLibrary.shared().performChanges {
//                let ca = PHAssetCreationRequest.creationRequestForAssetFromImage(atFileURL: url!)
                let creationAsset = PHAssetCreationRequest.forAsset()
                creationAsset.addResource(with: .photo, data: imageData, options: nil)
//                creationAsset.addResource(with: .alternatePhoto, data: (image?.pngData())!, options: nil)
            } completionHandler: { (success, error) in
                print(error.debugDescription)
            }

        }

    }
    
    public func save(imageData: Data, topImage: UIImage, bottomImage: UIImage) {
//        let timestamp = NSDate().timeIntervalSince1970
//        let imageName = "GlobUs_\(timestamp).jpeg"

//        let fileManager = FileManager.default
//        let url = fileManager.containerURL(forSecurityApplicationGroupIdentifier: "group.com.razhanov.globus")?.appendingPathComponent(imageName)

        // store image in group container
//        fileManager.createFile(atPath: url!.path as String, contents: imageData, attributes: nil)
        let image = UIImage(data: imageData)!
//        let addImage = UIImage(withContentsOfUrl: <#T##URL#>)
        let imageMerged = process(originalImage: image, topImage: topImage, bottomImage: bottomImage)
//        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)

        PHPhotoLibrary.requestAuthorization { (status) in
            guard status == .authorized else { return }
            PHPhotoLibrary.shared().performChanges {
//                let ca = PHAssetCreationRequest.creationRequestForAssetFromImage(atFileURL: url!)
                let creationAsset = PHAssetCreationRequest.forAsset()
//                creationAsset.addResource(with: .photo, data: imageData, options: nil)
//                creationAsset.addResource(with: .alternatePhoto, data: (image?.pngData())!, options: nil)
                creationAsset.addResource(with: .photo, data: (imageMerged?.pngData())!, options: nil)
            } completionHandler: { (success, error) in
                print(error.debugDescription)
            }

        }

    }

    /// Read data from the file and convert them into array of URLs for reading
    /// - Returns: The array of URLs
    public func readDataToURLs() -> [URL] {
        var urls: [URL] = []

        let fileManager = FileManager.default
        guard let sharedGroupPath = fileManager.containerURL(forSecurityApplicationGroupIdentifier: "group.com.razhanov.globus")?.path else {
            return urls
        }

        do {
            let fileNames = try fileManager.contentsOfDirectory(atPath: "\(sharedGroupPath)").filter({ $0.contains("GlobeUs") })

            for fileName in fileNames {
                let imageURL = URL(fileURLWithPath: sharedGroupPath).appendingPathComponent(fileName)
                urls.append(imageURL)
            }

            urls.sort(by: { $0.absoluteString.compare(
                    $1.absoluteString, options: .numeric) == .orderedDescending })

        } catch {
            print(error.localizedDescription)
        }

        return urls
    }

    /// Delete the image from the file directory
    /// - Parameters:
    ///   - image: The image to be deleted
    ///   - completion: Completion handler of success
    /// - Returns: The completion handler
    public func deleteData(imageURLToDelete url: URL, completion: (Bool) -> Void) {
        let fileManager = FileManager.default

        // Delete file in document directory
        if fileManager.fileExists(atPath: url.path) {
            do {
                try fileManager.removeItem(at: url)
                completion(true)
            } catch {
                print("Could not delete file: \(error)")
                completion(false)
            }
        }
    }
}

/// Extension for Widgets
extension DataEngine {
    public func randomPhoto() -> Photo? {
        guard let randomImageURL = readDataToURLs().randomElement() else {
            return Photo.static_photo
        }

        do {
            let imageData = try Data(contentsOf: randomImageURL)
            guard let image = UIImage(data: imageData) else { return nil }
            return Photo(image: image, url: randomImageURL)

        } catch {
            print("Error loading image : \(error)")
        }

        return nil
    }
}

extension DataEngine {
    public func process(originalImage image: UIImage, topImage: UIImage, bottomImage: UIImage) -> UIImage? {
        guard let topImage = topImage.aspectFitImage(inRect: CGRect(origin: .zero, size: image.size)), let bottomImage = bottomImage.aspectFitImage(inRect: CGRect(origin: .zero, size: image.size)) else { return nil }
        
        let xPos: CGFloat = 0//image.size.width * 0.7
        let yPos: CGFloat = 0//image.size.height * 0.9
        let yPosBottom: CGFloat = image.size.height - bottomImage.size.height
//        let fontSize: CGFloat = image.size.width * 0.038
        
        UIGraphicsBeginImageContext(image.size)
        
        // 1. Draw the photo
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        
        // 2. Configure datestamp
//        let rect = CGRect(x: 0, y: 0, width: 1000, height: 200)
        let rect = CGRect(x: 0, y: 0, width: topImage.size.width, height: topImage.size.height)
        let bottomRect = CGRect(x: 0, y: 0, width: bottomImage.size.width, height: bottomImage.size.height)
//        let renderer = UIGraphicsImageRenderer(bounds: rect)
//        
//        let addImage = renderer.image { (ctx) in
//            <#code#>
//        }
//        let datestamp = renderer.image { ctx in
//            let attrs: [NSAttributedString.Key: Any] = [
//                .font: UIFont(name: "Date Stamp Alt", size: fontSize)!,
//                .foregroundColor: UIColor(displayP3Red: 249/255, green: 148/255, blue: 60/255, alpha: 1)
//            ]
//
//            let attributedString = NSAttributedString(string: currentDate, attributes: attrs)
//            ctx.cgContext.setShadow(offset: .zero, blur: 15, color: UIColor.red.cgColor)
//            attributedString.draw(in: rect)
//        }
        
        // 3. Draw the datestamp
//        datestamp.draw(in: CGRect(x: xPos, y: yPos, width: rect.width, height: rect.height))
        topImage.draw(in: CGRect(x: xPos, y: yPos, width: rect.width, height: rect.height))
        bottomImage.draw(in: CGRect(x: xPos, y: yPosBottom, width: bottomRect.width, height: bottomRect.height))

        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
}

extension UIImage {

    convenience init?(withContentsOfUrl url: URL) throws {
        let imageData = try Data(contentsOf: url)
    
        self.init(data: imageData)
    }

}
