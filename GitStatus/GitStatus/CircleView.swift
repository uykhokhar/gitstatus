//
//  CircleView.swift
//  GitStatus
//
//  Created by Umar Khokhar on 2/6/17.
//  Copyright © 2017 Umar Khokhar. All rights reserved.
//

import UIKit

@IBDesignable class CircleView: UIView {

    // Attribution: - https://www.raywenderlich.com/90690/modern-core-graphics-with-swift-part-1
    @IBInspectable var circleColor : UIColor = UIColor.blue
    let π : CGFloat = CGFloat(M_PI)


    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        let radius: CGFloat = max(bounds.width, bounds.height)
        let arcWidth: CGFloat = 12
        
        let path = UIBezierPath(arcCenter: center,
                                radius: radius/2 - arcWidth/2,
                                startAngle: 0,
                                endAngle: 2*π,
                                clockwise: true)
        
        self.backgroundColor = UIColor(white: 1, alpha: 0.5)
        path.lineWidth = arcWidth
        circleColor.setStroke()
        path.stroke()
        self.backgroundColor = UIColor(white: 1, alpha: 0.5)
    }


}
