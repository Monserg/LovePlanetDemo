//
//  CircleButton.swift
//  LovePlanetDemo
//
//  Created by msm72 on 21.09.17.
//  Copyright © 2017 RemoteJob. All rights reserved.
//

import UIKit

class CircleButton: UIButton {
    // MARK: - Class Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.red.cgColor
        self.setTitle(NSLocalizedString("Start", comment: "Start action button"), for: .normal)
        self.setTitleColor(UIColor.red, for: .normal)
        self.setTitleColor(UIColor.blue, for: .highlighted)
        self.layer.cornerRadius = self.frame.width / 2
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: frame.height).isActive = true
        self.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Class Functions
    override func draw(_ rect: CGRect) {
    }
    
    
    // MARK: - Custom Functions
    func modifyState(_ isTapped: Bool) {
        self.layer.borderColor = (isTapped) ? UIColor.blue.cgColor : UIColor.red.cgColor
    }
}
