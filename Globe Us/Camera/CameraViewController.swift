//
//  CameraViewController.swift
//  Globe Us
//
//  Created by Karim on 28.02.2021.
//

import UIKit

enum WorkMode {
    case clouds
    case challenge
}

protocol CameraActionDelegate: class {
    func didSelect(cloud: CloudData?)
}

class CameraViewController: UIViewController {
    
    //MARK: - Class variables
    private let cameraEngine = CameraEngine()
    private let cameraView = PreviewMetalView(frame: .zero, device: MTLCreateSystemDefaultDevice())

    private var cameraActionView: CameraActionViewController!
    private var cameraActionViewHeight: CGFloat {
        return (self.view.frame.height - self.view.frame.height * 0.7) - (self.view.getSafeAreaInsets().top * 0.5)
    }
    
    private(set) lazy var topImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private(set) lazy var bottomImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var places: [Place] = [] {
        didSet {
            cameraActionView.places = self.places
        }
    }
    
    private var clouds: [CloudData] = [] {
        didSet {
            cameraActionView.clouds = self.clouds
        }
    }

    //MARK: - View Lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        makeConstraints()
        
        self.view.backgroundColor = .systemBackground
        CitiesService.getAllClouds(with: "Saint-Petersburg") { (result) in
            switch result {
            case .success(let cityResponse):
                self.clouds = cityResponse.data.city?.clouds ?? []
                self.places = cityResponse.data.place ?? []
            case .failure(let error):
                print(error)
            }
        }
//        CitiesService.getCities { (result) in
//            switch result {
//            case .success(let cities):
//                for city in cities.data {
//                    guard let places = city.places, places.count > 0 else { return }
//                    self.places = places
//                    print(city)
//                    break
//                }
//            case .failure(let error):
//                print("result error:", error)
//            }
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        #if !targetEnvironment(simulator)
        cameraEngine.startCaptureSession()
        #endif
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        #if !targetEnvironment(simulator)
        cameraEngine.addPreviewLayer(toView: cameraView)
        #endif
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        //Camera view
        cameraView.backgroundColor = .systemGray6
        cameraView.isUserInteractionEnabled = true
        
        self.view.addSubview(cameraView)
        
        cameraView.addSubview(topImageView)
        cameraView.addSubview(bottomImageView)
        
        //Camera action view
        cameraActionView = CameraActionViewController()
        cameraActionView.shutterSize = 60//cameraActionViewHeight * 0.4
        cameraActionView.cameraEngine = self.cameraEngine
        cameraActionView.delegate = self
        addVC(cameraActionView)
    }
    
    private func makeConstraints() {
        cameraView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view.frame.width) //* 0.95)
            make.height.equalTo(self.view.frame.height * 0.65)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(10)
            make.centerX.equalToSuperview()
        }
        topImageView.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
//            make.bottom.equalTo(cameraView.snp.centerY)
        }
        bottomImageView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
//            make.top.equalTo(cameraView.snp.centerY)
        }
        cameraActionView.view.snp.makeConstraints { (make) in
            make.width.equalTo(self.view.frame.width)
            make.height.equalTo(cameraActionViewHeight)
            make.bottom.equalToSuperview()
        }
    }
    
    /// Reset the camera view to improve performance
    func resetCameraView() {
        cameraView.pixelBuffer = nil
        cameraView.flushTextureCache()
    }

}

extension CameraViewController: CameraActionDelegate {
    func didSelect(cloud: CloudData?) {
        guard let cloud = cloud else { return }
//        topImageView.loadWithAlamofire(urlStringFull: cloud.topImage)
        topImageView.image = try? UIImage(withContentsOfUrl: URL(string: cloud.topImage)!)?.aspectFitImage(inRect: cameraView.frame)
        bottomImageView.image = try? UIImage(withContentsOfUrl: URL(string: cloud.bottomImage)!)?.aspectFitImage(inRect: cameraView.frame)
//        bottomImageView.loadWithAlamofire(urlStringFull: cloud.bottomImage)
    }
}

extension UIImage {

    func aspectFitImage(inRect rect: CGRect) -> UIImage? {
        let width = self.size.width
        let height = self.size.height
        let aspectWidth = rect.width / width
        let aspectHeight = rect.height / height
        let scaleFactor = aspectWidth > aspectHeight ? rect.size.height / height : rect.size.width / width

        UIGraphicsBeginImageContextWithOptions(CGSize(width: width * scaleFactor, height: height * scaleFactor), false, 0.0)
        self.draw(in: CGRect(x: 0.0, y: 0.0, width: width * scaleFactor, height: height * scaleFactor))

        defer {
            UIGraphicsEndImageContext()
        }

        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
