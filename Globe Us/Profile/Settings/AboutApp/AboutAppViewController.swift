//
//  AboutAppViewController.swift
//  Globe Us
//
//  Created by Михаил Беленко on 18.06.2021.
//

import UIKit

final class AboutAppViewController: UIViewController {
    var configurator = AboutAppConfiguratorImplementation()
    var presenter: AboutAppPresenter?
    
    private let reuseIdentifier = "AboutAppTableViewCell"
    
    private lazy var mainView: AboutAppView = {
        let view = AboutAppView()
        
        configureTableView(view.tableView)
        
        return view
    }()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        
        configurator.configure(viewController: self)
        presenter?.viewDidLoad()
    }
    
    private func configureNavigationBar() {
        let backButton = UIButton()
        backButton.setImage(UIImage(iconNamed: .backIconBlack), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonClick), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor(colorNamed: .textColor),
            .font: UIFont.systemFont(ofSize: 18)
        ]
        title = "О приложении"
    }
    
    private func configureTableView(_ tableView: UITableView) {
        tableView.register(AboutAppTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc private func backButtonClick() {
        presenter?.backAction()
    }
}

extension AboutAppViewController: AboutAppViewProtocol {
}

extension AboutAppViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        AboutAppTableViewCellType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? AboutAppTableViewCell else {
            let cell = AboutAppTableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
            presenter?.configureCell(cell, row: indexPath.row)
            return cell
        }
        
        presenter?.configureCell(cell, row: indexPath.row)
        return cell
    }
}
