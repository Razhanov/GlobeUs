//
//  ChallengesDetailViewController.swift
//  Globe Us
//
//  Created by Karim on 12.03.2021.
//

import UIKit

class ChallengesDetailViewController: UIViewController {
    
    private(set) lazy var challengesDetailView: ChallengesDetailView = {
        let view = ChallengesDetailView()
        view.backgroundColor = UIColor(hexString: "#14133D")
        view.backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        view.tableView.dataSource = self
        view.tableView.delegate = self
        return view
    }()
    
    var places: [Place] = [] {
        didSet {
            challengesDetailView.tableView.reloadData()
        }
    }
    
    override func loadView() {
        view = challengesDetailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @objc private func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func openDetail(_ sender: UIButton) {
        let vc = ChallengeDetailInfoViewController()
        guard let place = places.safe[sender.tag] else { return }
        vc.place = place
        present(vc, animated: true, completion: nil)
    }
    

}

extension ChallengesDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChallengesDetailTableViewCell", for: indexPath) as? ChallengesDetailTableViewCell else {
            return UITableViewCell()
        }
        guard let place = places.safe[indexPath.row] else { return UITableViewCell() }
        cell.display(place: place)
        cell.detailButton.addTarget(self, action: #selector(openDetail(_:)), for: .touchUpInside)
        cell.detailButton.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 420
    }
    
    
}
