//
//  ChallengeDetailInfoViewController.swift
//  Globe Us
//
//  Created by Karim on 12.03.2021.
//

import UIKit

class ChallengeDetailInfoViewController: UIViewController {
    
    private(set) lazy var challengeDetailInfoView: ChallengeDetailInfoView = {
        let view = ChallengeDetailInfoView()
        view.backgroundColor = .white
        return view
    }()
    
    var place: Place?
    
    override func loadView() {
        view = challengeDetailInfoView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let place = place else { return }
        challengeDetailInfoView.display(place: place)
    }

}
