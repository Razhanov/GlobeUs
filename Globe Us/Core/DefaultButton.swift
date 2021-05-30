//
//  DefaultButton.swift
//  Globe Us
//
//  Created by Михаил Беленко on 29.05.2021.
//

import UIKit

class DefaultButton: UIButton {

    override var isSelected: Bool {
        didSet {
            backgroundColor = UIColor(colorNamed: isSelected ? .mainColor : .mainSecondaryColor)
            setTitleColor(isSelected ? UIColor(colorNamed: .textColor) : UIColor(colorNamed: .textColor).withAlphaComponent(0.4), for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(colorNamed: .mainColor)
        setTitleColor(UIColor(colorNamed: .textColor), for: .normal)
        titleLabel?.font = .systemFont(ofSize: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
