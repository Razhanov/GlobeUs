//
//  SelectCityViewController.swift
//  Globe Us
//
//  Created by Михаил Беленко on 18.06.2021.
//

import UIKit

final class SelectCityViewController: UIViewController {
    var presenter: SelectCityPresenter?
    
    private let reuseIdentifier = "SelectCityTableViewCell"
    
    private lazy var mainView: SelectCityView = {
        let view = SelectCityView()
        
        configureTableView(view.tableView)
        
        return view
    }()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        
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
        title = "Выбор города посещения"
    }
    
    private func configureTableView(_ tableView: UITableView) {
        tableView.register(SelectCityTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc private func backButtonClick() {
        presenter?.backAction()
    }
}

extension SelectCityViewController: SelectCityViewProtocol {
    func setCities() {
        mainView.tableView.reloadData()
    }
}

extension SelectCityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getCitiesCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? SelectCityTableViewCell else {
            let cell = SelectCityTableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
            cell.delegate = presenter
            presenter?.configureCell(cell, row: indexPath.row)
            return cell
        }
        
        cell.delegate = presenter
        presenter?.configureCell(cell, row: indexPath.row)
        return cell
    }
}
