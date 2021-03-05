//
//  MainViewController.swift
//  Globe Us
//
//  Created by Karim Razhanov on 12.07.2020.
//

import Foundation
import UIKit
import AVFoundation
import Photos

class MainViewController : UIImagePickerController {
    
    var configurator = MainConfiguratorImplementation()
    var presenter: MainPresenter?
    
    override var prefersStatusBarHidden: Bool { return true }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation { .fade }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { .portrait }
    
    override var shouldAutorotate: Bool {
        return UIDevice.current.orientation == .portrait
    }
    
    
    
    private(set) lazy var mainView: MainView = {
        let view = MainView()
        return view
    }()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        configurator.configure(viewController: self)
        presenter?.viewDidLoad()

        print(self.view.safeAreaInsets)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter?.viewWillDisappear()
    }
    
}

extension MainViewController : MainViewProtocol {
    func setMenuHiding() {
        mainView.setMenuHiding()
    }
    func setMenuShowing() {
        mainView.setMenuShowing()
    }
    func setView() {
//        presenter?.configureCameraController(on: mainView.view)
    }
    func showSettingsAlert() {
        UIAlertController.showSettingsAlertIn(self, title: nil, message: "Allow access to Camera")
    }
    func showSimpleAlertIn() {
        UIAlertController.showSimpleAlertIn(self.navigationController, title: "Error", message: "Failed to capture image")
    }
}

extension MainViewController: AVCapturePhotoCaptureDelegate {
    @objc func image(_ image: UIImage,
            didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
            if let error = error {
                print("ERROR: \(error)")
            }
        }
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        print("captured photo", photo.debugDescription)
        
        guard let data = photo.fileDataRepresentation() else { print("error"); return }
        
        print("preview view size:", mainView.previewView.bounds.size)
        guard let image = UIImage(data: data)?.crop(with: mainView.previewView.bounds) else { return }

        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        
        
        guard error == nil else {
            print("Error capturing photo: \(error!)")
            return
        }
        
//        PHPhotoLibrary.requestAuthorization { (status) in
//            guard status == .authorized else { return }
//            PHPhotoLibrary.shared().performChanges {
//                let creationAsset = PHAssetCreationRequest.forAsset()
////                creationAsset.addResource(with: .photo, data: photo.fileDataRepresentation()!, options: nil)
//                creationAsset.addResource(with: .alternatePhoto, data: (image?.pngData())!, options: nil)
//            } completionHandler: { (success, error) in
//                print(error.debugDescription)
//            }
//
//        }
        
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}

extension UIImage {
    func cropToBounds(_ size: CGSize) -> UIImage {

            let cgimage = self.cgImage!
            let contextImage: UIImage = UIImage(cgImage: cgimage)
            let contextSize: CGSize = contextImage.size
            var posX: CGFloat = 0.0
            var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(size.width)
        var cgheight: CGFloat = CGFloat(size.height)

            // See what size is longer and create the center off of that
            if contextSize.width > contextSize.height {
                posX = ((contextSize.width - contextSize.height) / 2)
                posY = 0
                cgwidth = contextSize.height
                cgheight = contextSize.height
            } else {
                posX = 0
                posY = ((contextSize.height - contextSize.width) / 2)
                cgwidth = contextSize.width
                cgheight = contextSize.width
            }

            let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)

            // Create bitmap image from context using the rect
            let imageRef: CGImage = cgimage.cropping(to: rect)!

            // Create a new image based on the imageRef and rotate back to the original orientation
            let image: UIImage = UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)

            return image
        }
}

extension UIImage {
    func crop(with rect: CGRect) -> UIImage {
        let originalSize: CGSize
        // Calculate the fractional size that is shown in the preview
//        guard let metaRect = previewLayer?.metadataOutputRectConverted(fromLayerRect: rect) else {
//            throw MFCameraError.noMetaRect
//        }
        //
        let metaRect = CameraController.shared.getMetaRect(from: rect)
        //
        if imageOrientation == UIImage.Orientation.left
            || imageOrientation == UIImage.Orientation.right {
            // For these images (which are portrait), swap the size of the
            // image, because here the output image is actually rotated
            // relative to what you see on screen.
            originalSize = CGSize(width: size.height,
                                  height: size.width)
        } else {
            originalSize = size
        }
        
        let x = metaRect.origin.x * originalSize.width
        let y = metaRect.origin.y * originalSize.height
        // metaRect is fractional, that's why we multiply here.
        let cropRect: CGRect = CGRect( x: x,
                                       y: y,
                                       width: metaRect.size.width * originalSize.width,
                                       height: metaRect.size.height * originalSize.height).integral
        guard let cropedCGImage = cgImage?.cropping(to: cropRect) else {
//            throw MFCameraError.crop
            return UIImage()
        }
        
        return  UIImage(cgImage: cropedCGImage,
                        scale: 1,
                        orientation: imageOrientation)
    }
    
}
