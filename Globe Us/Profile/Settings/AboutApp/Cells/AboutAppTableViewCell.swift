//
//  AboutAppTableViewCell.swift
//  Globe Us
//
//  Created by Михаил Беленко on 18.06.2021.
//

import UIKit

enum AboutAppTableViewCellType: Int, CaseIterable {
    case feedback, rateApp, privacyPolicy, termsUse
    
    var description: String {
        switch self {
        case .feedback:
            return "Обратная связь"
        case .rateApp:
            return "Оценить приложение"
        case .privacyPolicy:
            return "Политика конфиденциальности"
        case .termsUse:
            return "Пользовательское соглашение"
        }
    }
}

class AboutAppTableViewCell: UITableViewCell {
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(colorNamed: .textColor)
        label.textAlignment = .left
        return label
    }()
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initilizate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initilizate() {
        selectionStyle = .none
        
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
}
