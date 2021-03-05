//
//  MainView.swift
//  Globe Us
//
//  Created by Karim Razhanov on 12.07.2020.
//

import Foundation
import UIKit
import SnapKit

class MainView : UIView {

    private(set) lazy var view: UIView = {
        let view = UIView()
        return view
    }()
    
    private(set) lazy var previewView: UIView = {
        let view = UIView()
        return view
    }()
    
    private(set) lazy var overlayView: UIView = {
        let view = UIView()
        return view
    }()
    
    private(set) lazy var toolBarView: UIView = {
        let view = UIView()
        return view
    }()
    
    private(set) lazy var cameraButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "capture_photo"), for: .normal)
        return button
    }()
    
    private(set) lazy var switchCameraButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "switch_camera"), for: .normal)
        return button
    }()
    
    private(set) lazy var clipsButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = 22
        button.setImage(UIImage(named: "demo_image"), for: .normal)
        return button
    }()
    
    private(set) lazy var toolBarBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#14133D")
        return view
    }()
    
    private(set) lazy var mergeButtonView: UIView = {
        let view = UIView()
        return view
    }()
    
    private(set) lazy var mergeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "merge"), for: .normal)
        return button
    }()
    
    private(set) lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 64, height: 64)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    func setMenuShowing() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            self.toolBarBackgroundView.frame.origin.y -= (170 + self.safeAreaInsets.bottom)
            self.toolBarBackgroundView.alpha = 1
        }
    }
    
    func setMenuHiding() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            self.toolBarBackgroundView.alpha = 0
            self.toolBarBackgroundView.frame.origin.y += (170 + self.safeAreaInsets.bottom)
        }
    }
    
    override func layoutSubviews() {
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        addSubview(view)
        view.addSubview(previewView)
        view.addSubview(overlayView)
        view.addSubview(toolBarBackgroundView)
        view.addSubview(toolBarView)
        toolBarView.addSubview(cameraButton)
        toolBarView.addSubview(switchCameraButton)
        toolBarView.addSubview(clipsButton)
        toolBarView.addSubview(mergeButtonView)
        mergeButtonView.addSubview(mergeButton)
        toolBarView.addSubview(collectionView)
    }
    
    private func makeConstraints() {
        view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        previewView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        overlayView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        toolBarBackgroundView.snp.makeConstraints { (make) in
            make.height.equalTo(170 + self.safeAreaInsets.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        toolBarView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.layoutMarginsGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(170)
        }
        cameraButton.snp.makeConstraints { (make) in
            make.height.width.equalTo(60)
            make.bottom.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
        switchCameraButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(cameraButton)
            make.trailing.equalToSuperview().inset(28)
            make.height.width.equalTo(27)
        }
        clipsButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(cameraButton)
            make.height.width.equalTo(44)
            make.leading.equalToSuperview().offset(28)
        }
        mergeButtonView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(cameraButton.snp.right)
            make.right.equalTo(switchCameraButton.snp.left)
        }
        mergeButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(cameraButton)
            make.width.height.equalTo(22)
            make.centerX.equalToSuperview()
        }
        collectionView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(64)
        }
    }
}


extension UIColor {
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
