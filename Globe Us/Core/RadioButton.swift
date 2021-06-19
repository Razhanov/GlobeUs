//
//  RadioButton.swift
//  Globe Us
//
//  Created by Михаил Беленко on 12.06.2021.
//

import UIKit

class RadioButton: UIButton {

    override var isSelected: Bool {
        didSet {
            setImage(UIImage(iconNamed: isSelected ? .radioButtonSelect : .radioButtonUnselect), for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setImage(UIImage(iconNamed: isSelected ? .radioButtonSelect : .radioButtonUnselect), for: .normal)
        setTitleColor(UIColor(colorNamed: .textColor), for: .normal)
        titleLabel?.font = .systemFont(ofSize: 14)
        
        titleEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: -8)
    }
    
    convenience init(title: String) {
        self.init()
        
        setTitle(title, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
