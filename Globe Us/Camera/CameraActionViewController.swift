//
//  CameraActionViewController.swift
//  Globe Us
//
//  Created by Karim on 28.02.2021.
//

import UIKit
import SnapKit

class CameraActionViewController: UIViewController {

    var shutterSize: CGFloat!

    private var shutterButton: ShutterButtonViewController!
    
    private(set) lazy var switchCameraButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "switch_camera"), for: .normal)
        return button
    }()
    
    private let stickersLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return layout
    }()
    
    private let workModeLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return layout
    }()
    
    private(set) lazy var stickersCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: stickersLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(StickersCollectionViewCell.self, forCellWithReuseIdentifier: "StickersCollectionViewCell")
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private(set) lazy var workModeCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: workModeLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(WorkModeCollectionViewCell.self, forCellWithReuseIdentifier: "WorkModeCollectionViewCell")
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private(set) lazy var challengeView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.isHidden = true
        view.layer.borderColor = UIColor(red: 1, green: 0.671, blue: 0.173, alpha: 0.5).cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private(set) lazy var challengeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 35
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private(set) lazy var challengeTitlaLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Geometria-Medium", size: 14)
        return label
    }()
    
    private(set) lazy var openMapButton: UIButton = {
        let button = UIButton()
        button.setTitle("Открыть в навигаторе", for: .normal)
        button.titleLabel?.textColor = UIColor(red: 0.078, green: 0.075, blue: 0.239, alpha: 1)
        button.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 12)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red: 1, green: 0.671, blue: 0.173, alpha: 1)
        button.setTitleColor(UIColor(red: 0.078, green: 0.075, blue: 0.239, alpha: 1), for: .normal)
        return button
    }()

    weak var cameraEngine: CameraEngine?
    
    weak var delegate: CameraActionDelegate?
    
    var places: [Place] = [] {
        didSet {
            guard let place = places.first else { return }
            challengeImageView.loadWithAlamofire(urlStringFull: place.images.first ?? "")
            challengeTitlaLabel.text = place.title
        }
    }
    
    var clouds: [CloudData] = [] {
        didSet {
            stickersCollectionView.reloadData()
        }
    }
    
    private var stickerHeight: CGFloat {
        return workModeEnum == .clouds ? 64 : 64//93
    }
    
    private var stickerWidth: CGFloat  {
        return workModeEnum == .clouds ? 64 : 64//UIScreen.main.bounds.width - 32
    }
    
    private var workModeEnum: WorkMode = .clouds {
        didSet {
            stickersCollectionView.isHidden = workModeEnum == .challenge
            challengeView.isHidden = workModeEnum == .clouds
            stickersCollectionView.reloadData()
            delegate?.setWorkMode(self.workModeEnum)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.view.backgroundColor = UIColor(red: 0.077, green: 0.073, blue: 0.237, alpha: 1)
        switchCameraButton.addTarget(self, action: #selector(switchCamera), for: .touchUpInside)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        shutterButton.view.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(20)
        }
        switchCameraButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(27)
            make.trailing.equalToSuperview().inset(27)
            make.centerY.equalTo(shutterButton.view.snp.centerY)
        }
        stickersCollectionView.snp.makeConstraints { (make) in
            make.bottom.equalTo(shutterButton.view.snp.top).offset(-12)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(93)//114)
        }
        workModeCollectionView.snp.makeConstraints { (make) in
            make.bottom.equalTo(stickersCollectionView.snp.top).offset(-12)//lessThanOrEqualTo(stickersCollectionView.snp.top).offset(-12)
//            make.top.greaterThanOrEqualToSuperview().offset(8)
            make.height.equalTo(56)
            make.leading.trailing.equalToSuperview()
        }
        challengeView.snp.makeConstraints { (make) in
            make.bottom.equalTo(shutterButton.view.snp.top).offset(-12)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(93)
        }
        challengeImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(70)
            make.leading.equalToSuperview().offset(19)
            make.centerY.equalToSuperview()
        }
        challengeTitlaLabel.snp.makeConstraints { (make) in
            make.left.equalTo(challengeImageView.snp.right).offset(17)
            make.top.equalTo(challengeImageView.snp.top)
        }
        openMapButton.snp.makeConstraints { (make) in
            make.left.equalTo(challengeImageView.snp.right).offset(17)
            make.height.equalTo(24)
//            make.width.equalTo(143)
            make.width.equalToSuperview().multipliedBy(0.55)
            make.bottom.equalTo(challengeImageView.snp.bottom)
        }
        self.view.layoutIfNeeded()
    }

    //MARK: - Setup UI
    private func setupUI() {
        shutterButton = ShutterButtonViewController()
        shutterButton.oriFrame = CGSize(width: shutterSize, height: shutterSize)
        self.addVC(shutterButton)
        self.view.addSubview(switchCameraButton)
        self.view.addSubview(stickersCollectionView)
        self.view.addSubview(workModeCollectionView)
        self.view.addSubview(challengeView)
        challengeView.addSubview(challengeImageView)
        challengeView.addSubview(challengeTitlaLabel)
        challengeView.addSubview(openMapButton)
    }
}

extension CameraActionViewController {
    @objc func switchCamera() {
        cameraEngine?.switchCamera()
    }
}

//MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension CameraActionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == stickersCollectionView {
            return clouds.count
        } else if collectionView == workModeCollectionView {
            return 2
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == stickersCollectionView {
            let cloud = clouds.safe[indexPath.row]
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StickersCollectionViewCell", for: indexPath) as? StickersCollectionViewCell else {
                let cell = StickersCollectionViewCell()
                cell.update(with: cloud)
                return cell
            }
            cell.update(with: cloud)
            return cell
        } else if collectionView == workModeCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WorkModeCollectionViewCell", for: indexPath) as? WorkModeCollectionViewCell else {
                let cell = WorkModeCollectionViewCell()
                cell.cloudsView.isHidden = indexPath.row != 0
                cell.challengeView.isHidden = indexPath.row != 1
                return cell
            }
            cell.cloudsView.isHidden = indexPath.row != 0
            cell.challengeView.isHidden = indexPath.row != 1
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == workModeCollectionView {
            if indexPath.row == 0 {
                workModeEnum = .clouds
            } else {
                workModeEnum = .challenge
            }
        } else if collectionView == stickersCollectionView {
            let cloud = clouds.safe[indexPath.row]
            delegate?.didSelect(cloud: cloud)
            shutterButton.cloud = cloud
        }
    }
    
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension CameraActionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == stickersCollectionView {
            return CGSize(width: stickerWidth, height: stickerHeight)
        } else if collectionView == workModeCollectionView {
            return CGSize(width: self.view.frame.size.width * 0.7, height: 56)
        } else {
            return .zero
        }
    }
}
