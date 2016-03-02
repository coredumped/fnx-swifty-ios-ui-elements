//
//  RoundCorneredView.swift
//  swiftyui4ios
//
//  Created by Juan Guerrero on 2/26/16.
//  Copyright © 2016 fn(x) Software. All rights reserved.
//

import UIKit

@IBDesignable
public class RoundCorneredRectView: UIView {
    
    var roundedRectLayer : CAShapeLayer?
    
    @IBInspectable
    var showBorder : Bool = false {
        didSet {
            setNeedsLayout()
        }
    }
    @IBInspectable
    var borderColor : UIColor = UIColor.blackColor() {
        didSet {
            setNeedsLayout()
        }
    }
    @IBInspectable
    var borderWidth : CGFloat = 1.0 {
        didSet {
            setNeedsLayout()
        }
    }
    @IBInspectable
    var cornerRadius : CGFloat = 8.0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        roundedRectLayer = CAShapeLayer()
        let roundedRect : UIBezierPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius)
        roundedRectLayer?.path = roundedRect.CGPath
        layer.mask = roundedRectLayer
        if(showBorder) {
            let borderLayer = CAShapeLayer()
            let border = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius)
            borderLayer.strokeColor = borderColor.CGColor
            borderLayer.fillColor = UIColor(white: 0.0, alpha: 0.0).CGColor
            borderLayer.lineWidth = self.borderWidth
            borderLayer.lineJoin = kCALineJoinRound
            borderLayer.path = border.CGPath
            layer.addSublayer(borderLayer)
        }
    }
    
}
