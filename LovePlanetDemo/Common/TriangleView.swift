//
//  TriangleView.swift
//  LovePlanetDemo
//
//  Created by msm72 on 21.09.17.
//  Copyright © 2017 RemoteJob. All rights reserved.
//

import UIKit

class TriangleView: UIView {
    // MARK: - Class Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Class Functions
    override func draw(_ rect: CGRect) {
        let path = trianglePathWithCenter()
        let greenColor = UIColor.green
        
        greenColor.setFill()
        greenColor.setStroke()
        path.fill()
        path.stroke()
    }
    
    
    // MARK: - Custom Functions
    func trianglePathWithCenter() -> UIBezierPath {
        let path = UIBezierPath()
        let startX = self.frame.minX + 10
        let startY = self.frame.maxY - 10
        
        path.move(to: CGPoint(x: startX, y: startY))
        path.addLine(to: CGPoint(x: startX + self.frame.width - 20, y: startY))
        path.addLine(to: CGPoint(x: self.frame.midX, y: self.frame.minY + 10))
        path.close()
        
        return path
    }
}
