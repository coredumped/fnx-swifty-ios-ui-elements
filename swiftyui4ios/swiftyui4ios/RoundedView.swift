//
//  RoundedView.swift
//  swiftyui4ios
//
//  Created by Juan Guerrero on 2/11/15.
//  Copyright (c) 2015 fn(x) Software. All rights reserved.
//

import UIKit

@IBDesignable
open class RoundedView: UIView {
    
    var roundLayer : CAShapeLayer?
    
    @IBInspectable
    var showBorder : Bool = false
    @IBInspectable
    var borderColor : UIColor = UIColor.black
    @IBInspectable
    var borderWidth : CGFloat = 1.0
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        roundLayer = CAShapeLayer()
        let circle : UIBezierPath = UIBezierPath(ovalIn: bounds)
        roundLayer?.path = circle.cgPath
        layer.mask = roundLayer
        if(showBorder) {
            let borderLayer = CAShapeLayer()
            let border = UIBezierPath(ovalIn: bounds)
            border.lineWidth = borderWidth
            borderLayer.strokeColor = borderColor.cgColor
            borderLayer.fillColor = UIColor(white: 0.0, alpha: 0.0).cgColor
            borderLayer.path = border.cgPath
            border.stroke(with: CGBlendMode.multiply, alpha: 0.8)
            layer.addSublayer(borderLayer)
        }
    }

}
