//
//  ChallengesDetailView.swift
//  Globe Us
//
//  Created by Karim on 12.03.2021.
//

import UIKit

class ChallengesDetailView: UIView {

    private(set) lazy var headerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private(set) lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back_icon"), for: .normal)
        let attributes: [NSAttributedString.Key : Any] = [
            .font: UIFont(name: "Geometria-Medium", size: 18) ?? .systemFont(ofSize: 18, weight: .medium),
            .foregroundColor: UIColor.white
        ]
        let attTitle = NSAttributedString(string: "Челлендж", attributes: attributes)
        button.setAttributedTitle(attTitle, for: .normal)
        return button
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Geometria-Medium", size: 12) ?? .systemFont(ofSize: 12, weight: .medium)
        label.text = "Точки Силы Города"
        label.textColor = UIColor(red: 0.537, green: 0.373, blue: 0.204, alpha: 1)
        return label
    }()
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ChallengesDetailTableViewCell.self, forCellReuseIdentifier: "ChallengesDetailTableViewCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
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
        addSubview(headerView)
        headerView.addSubview(backButton)
        headerView.addSubview(titleLabel)
        addSubview(tableView)
    }
    
    private func makeConstraints() {
        headerView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(layoutMarginsGuide)
            make.height.equalTo(72)
        }
        backButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(18)
            make.top.equalToSuperview().offset(13)
            make.height.equalTo(40)
            make.width.equalTo(122)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(backButton.snp.bottom)
            make.leading.equalToSuperview().offset(52)
        }
        tableView.snp.makeConstraints { (make) in
            make.bottom.leading.trailing.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom).offset(8)
        }
    }

}
