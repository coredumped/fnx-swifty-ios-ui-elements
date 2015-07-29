//
//  RoundedView.swift
//  swiftyui4ios
//
//  Created by Juan Guerrero on 2/11/15.
//  Copyright (c) 2015 fn(x) Software. All rights reserved.
//

import UIKit

@IBDesignable
public class RoundedView: UIView {
    
    var roundLayer : CAShapeLayer?
    
    @IBInspectable
    var showBorder : Bool = false
    @IBInspectable
    var borderColor : UIColor = UIColor.blackColor()
    @IBInspectable
    var borderWidth : CGFloat = 1.0
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        roundLayer = CAShapeLayer()
        var circle : UIBezierPath = UIBezierPath(ovalInRect: bounds)
        roundLayer?.path = circle.CGPath
        layer.mask = roundLayer
        if(showBorder) {
            var borderLayer = CAShapeLayer()
            var border = UIBezierPath(ovalInRect: bounds)
            border.lineWidth = borderWidth
            borderLayer.strokeColor = borderColor.CGColor
            borderLayer.fillColor = UIColor(white: 0.0, alpha: 0.0).CGColor
            borderLayer.path = border.CGPath
            border.strokeWithBlendMode(kCGBlendModeMultiply, alpha: 0.8)
            layer.addSublayer(borderLayer)
        }
    }

}
