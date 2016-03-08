//
//  IndefiniteProgressView.swift
//  swiftyui4ios
//
//  Created by Juan Guerrero on 3/3/16.
//  Copyright © 2016 fn(x) Software. All rights reserved.
//

import UIKit

@IBDesignable
public class IndefiniteProgressView: UIView {
    public enum ProgressStyle {
        case Circular, Custom
    }
    
    public enum ProgressStylingError : ErrorType {
        case StyleNotSupported
    }
    
    private var animationLayer : CALayer?
    private var startProgressAnimation : CABasicAnimation?

    
    
    @IBInspectable
    public var animating = false {
        didSet {
            if animating {
                animationLayer?.opacity = 1

                let contentLayer = CAShapeLayer()
                drawIndicatorToLayer(contentLayer)
                animationLayer!.addSublayer(contentLayer)
                contentLayer.position = CGPoint(x: 0.5, y: 0.5)
                startAnimation()
            }
            else {
                animationLayer?.opacity = 0
                animationLayer?.removeAllAnimations()
                startProgressAnimation = nil
            }
        }
    }
    
    @IBInspectable
    public var style : ProgressStyle = .Circular {
        didSet {
            setup()
            self.setNeedsLayout()
        }
    }
    
    private func startAnimation () {
        if style == .Circular {
            if startProgressAnimation == nil {
                startProgressAnimation = CABasicAnimation()
                startProgressAnimation?.fromValue = 0
                startProgressAnimation?.toValue = M_PI * 2.0
                startProgressAnimation?.duration = 1
                startProgressAnimation?.keyPath = "transform.rotation.z"
                startProgressAnimation?.removedOnCompletion = true
                startProgressAnimation?.repeatCount = Float.infinity
            }
            self.animationLayer?.addAnimation(startProgressAnimation!, forKey: "transform.rotation.z")
        }
    }
    
    private func diameterForCircularBorder () -> CGFloat {
        var diameter = self.bounds.width
        if self.bounds.height < self.bounds.width {
            diameter = self.bounds.height
        }
        return diameter
    }
    
    
    private func drawIndicatorToLayer (theLayer : CAShapeLayer)  {
        if style == .Circular {
            let diameter = diameterForCircularBorder()
            let radius = diameter / 2.0
            let centerX = CGPoint(x: self.bounds.width / 2.0, y: self.bounds.height / 2.0)
            let circle = UIBezierPath(arcCenter: centerX, radius: radius, startAngle: 0.0, endAngle: CGFloat(4.0 * M_PI / 2.125), clockwise: true)
            theLayer.opacity = 1.0
            theLayer.path = circle.CGPath
            theLayer.lineWidth = diameter / 10.0
            theLayer.strokeColor = self.tintColor.CGColor
            theLayer.fillColor = UIColor(white: 1.0, alpha: 0.0).CGColor
            theLayer.lineCap = kCALineCapButt
        }
    }
    
    private func applyCircularBorderMaskWithDiameter (diameter : CGFloat) {
        let borderMask = UIBezierPath(ovalInRect: CGRectMake((self.bounds.width - diameter) / 2.0, (self.bounds.height - diameter) / 2.0, diameter, diameter))
        let borderLayer = CAShapeLayer()
        borderLayer.path = borderMask.CGPath
        self.layer.mask = borderLayer
    }
    
    private func setup () {
        if style == .Circular {
            if(self.animationLayer != nil) {
                self.animationLayer?.removeFromSuperlayer()
            }
            self.animationLayer = CALayer()
            self.animationLayer?.bounds = self.bounds
            self.animationLayer?.setAffineTransform(CGAffineTransformMakeTranslation(self.bounds.width / 2.0, self.bounds.height / 2.0))
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
    
    public override func prepareForInterfaceBuilder() {

        let contentLayer = CAShapeLayer()
        drawIndicatorToLayer(contentLayer)
        self.layer.addSublayer(contentLayer)
        super.prepareForInterfaceBuilder()
    }
}
