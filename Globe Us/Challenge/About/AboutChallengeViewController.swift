//
//  AboutChallengeViewController.swift
//  Globe Us
//
//  Created by Karim on 12.03.2021.
//

import UIKit

class AboutChallengeViewController: UIViewController {
    
    private(set) lazy var aboutChallengeView: AboutChallengeView = {
        let view = AboutChallengeView()
        view.backgroundColor = .white
        view.closeButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        return view
    }()
    
    override func loadView() {
        view = aboutChallengeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc private func closeAction() {
        dismiss(animated: true, completion: nil)
    }

}
