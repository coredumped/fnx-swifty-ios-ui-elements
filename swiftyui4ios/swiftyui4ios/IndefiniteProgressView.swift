//
//  IndefiniteProgressView.swift
//  swiftyui4ios
//
//  Created by Juan Guerrero on 3/3/16.
//  Copyright © 2016 fn(x) Software. All rights reserved.
//

import UIKit

@IBDesignable
open class IndefiniteProgressView: UIView {
    public enum ProgressStyle {
        case circular, custom
    }
    
    public enum ProgressStylingError : Error {
        case styleNotSupported
    }
    
    fileprivate var animationLayer : CALayer?
    fileprivate var startProgressAnimation : CABasicAnimation?

    
    
    @IBInspectable
    open var animating = false {
        didSet {
            if animating {
                animationLayer?.opacity = 1
                let contentLayer = CAShapeLayer()
                contentLayer.position = CGPoint(x: 0, y: 0)
                drawIndicatorToLayer(contentLayer)
                animationLayer!.addSublayer(contentLayer)
                startAnimation()
            }
            else {
                animationLayer?.opacity = 0
                animationLayer?.removeAllAnimations()
                startProgressAnimation = nil
            }
        }
    }
    
    open var style : ProgressStyle = .circular {
        didSet {
            setup()
            self.setNeedsLayout()
        }
    }
    
    fileprivate func startAnimation () {
        if style == .circular {
            if startProgressAnimation == nil {
                startProgressAnimation = CABasicAnimation()
                startProgressAnimation?.fromValue = 0
                startProgressAnimation?.toValue = M_PI * 2.0
                startProgressAnimation?.duration = 1
                startProgressAnimation?.keyPath = "transform.rotation.z"
                startProgressAnimation?.isRemovedOnCompletion = true
                startProgressAnimation?.repeatCount = Float.infinity
            }
            self.animationLayer?.add(startProgressAnimation!, forKey: "transform.rotation.z")
        }
    }
    
    fileprivate func diameterForCircularBorder () -> CGFloat {
        var diameter = self.bounds.width
        if self.bounds.height < self.bounds.width {
            diameter = self.bounds.height
        }
        return diameter
    }
    
    
    fileprivate func drawIndicatorToLayer (_ theLayer : CAShapeLayer)  {
        if style == .circular {
            let diameter = diameterForCircularBorder()
            let radius = diameter / 2.0
            let centerX = CGPoint(x: 0.0, y: 0.0)
            let circle = UIBezierPath(arcCenter: centerX, radius: radius, startAngle: 0.0, endAngle: CGFloat(4.0 * M_PI / 2.125), clockwise: true)
            theLayer.opacity = 1.0
            theLayer.path = circle.cgPath
            theLayer.lineWidth = diameter / 10.0
            theLayer.strokeColor = self.tintColor.cgColor
            theLayer.fillColor = UIColor(white: 1.0, alpha: 0.0).cgColor
            theLayer.lineCap = kCALineCapButt
        }
    }
    
    fileprivate func applyCircularBorderMaskWithDiameter (_ diameter : CGFloat) {
        let borderMask = UIBezierPath(ovalIn: CGRect(x: (self.bounds.width - diameter) / 2.0, y: (self.bounds.height - diameter) / 2.0, width: diameter, height: diameter))
        let borderLayer = CAShapeLayer()
        borderLayer.path = borderMask.cgPath
        self.layer.mask = borderLayer
    }
    
    fileprivate func setup () {
        if style == .circular {
            if(self.animationLayer != nil) {
                self.animationLayer?.removeFromSuperlayer()
            }
            self.animationLayer = CALayer()
            let hh = self.bounds.size.height / 2.0
            let hw = self.bounds.size.width / 2.0
            self.animationLayer?.bounds = CGRect(x: -hw, y: -hh, width: self.bounds.width, height: self.bounds.height)
            self.animationLayer?.setAffineTransform(CGAffineTransform(translationX: self.bounds.size.width / 2.0, y: self.bounds.size.height / 2.0))
            self.layer.addSublayer(animationLayer!)
            applyCircularBorderMaskWithDiameter(diameterForCircularBorder())
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    open override func prepareForInterfaceBuilder() {
        style = .circular
    }
}
