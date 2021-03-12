//
//  ChallengesView.swift
//  Globe Us
//
//  Created by Karim on 11.03.2021.
//

import UIKit

class ChallengesView: UIView {

    private(set) lazy var view: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#14133D")
        return view
    }()
    
    private(set) lazy var headerView: ChallengeHeaderView = {
        let view = ChallengeHeaderView()
        view.backgroundColor = UIColor(hexString: "#FFAB2C")
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    private(set) lazy var headerBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#FFAB2C")
        return view
    }()
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.register(ChallengeInfoTableViewCell.self, forCellReuseIdentifier: "ChallengeInfoTableViewCell")
        tableView.register(ChallengeArrowTableViewCell.self, forCellReuseIdentifier: "ChallengeArrowTableViewCell")
        tableView.backgroundColor = .clear
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(view)
        view.addSubview(headerView)
        view.addSubview(headerBackgroundView)
        view.addSubview(tableView)
    }
    
    private func makeConstraints() {
        view.snp.makeConstraints { (make) in
            make.edges.equalTo(self.layoutMarginsGuide)
        }
        headerView.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(140)
        }
        headerBackgroundView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(20)
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

}
