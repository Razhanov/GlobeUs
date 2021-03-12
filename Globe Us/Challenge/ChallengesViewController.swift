//
//  ChallengesViewController.swift
//  Globe Us
//
//  Created by Karim on 11.03.2021.
//

import UIKit

class ChallengesViewController: UIViewController {
    
    private(set) lazy var challengesView: ChallengesView = {
        let view = ChallengesView()
        view.tableView.delegate = self
        view.tableView.dataSource = self
        view.headerView.backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        view.headerView.detailButton.addTarget(self, action: #selector(openChallengesDetail), for: .touchUpInside)
        return view
    }()
    
    var places: [Place] = [] {
        didSet {
            challengesView.headerView.detailLabel.text = "\(places.count) точек"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(challengesView)
        challengesView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    @objc private func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func openChallengesDetail() {
        let vc = ChallengesDetailViewController()
        vc.places = places
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension ChallengesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count * 2 - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 != 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChallengeArrowTableViewCell", for: indexPath) as? ChallengeArrowTableViewCell else {
                return UITableViewCell()
            }
            let row: Float = Float(indexPath.row) / 2
            cell.display(at: Int(ceil(row)))
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChallengeInfoTableViewCell", for: indexPath) as? ChallengeInfoTableViewCell else {
                return UITableViewCell()
            }
            let row: Float = Float(indexPath.row) / 2
            let rowInt = Int(ceil(row))
            guard let place = places.safe[rowInt] else { return UITableViewCell() }
            cell.set(place: place, for: rowInt)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row % 2 != 0 {
            return 33
        } else {
            return 66
        }
    }
    
}
