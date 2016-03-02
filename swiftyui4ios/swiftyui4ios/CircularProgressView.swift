//
//  CircularProgressView.swift
//  swiftyui4ios
//
//  Created by Juan Guerrero on 7/28/15.
//  Copyright (c) 2015 fn(x) Software. All rights reserved.
//

import UIKit

@IBDesignable
public class CircularProgressView: UIView {
    
    private var progressLayer : CALayer?
    private var borderLayer : CAShapeLayer = CAShapeLayer()
    
    private func setup() {
        //self.contentMode = .Redraw
        self.backgroundColor = UIColor.clearColor()
        progressLayer = CALayer()
        self.layer.addSublayer(progressLayer!)
        
        
        
        //borderLayer = CAShapeLayer()
        
        borderLayer.fillColor = UIColor.clearColor().CGColor
        borderLayer.strokeColor = tintColor.CGColor
        self.layer.addSublayer(borderLayer)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    /*
    public override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        //updateProgress()
        progressLayer.
    }
    */
    
    
    private var prevProgress : CGFloat = 0
    
    @IBInspectable public var progress : CGFloat = 0.0 {
        didSet {
            self.setNeedsLayout()
            if progress <= 0.0 {
                prevProgress = 0.0
                self.progressLayer?.removeAllAnimations()
            }
        }
    }
    
    @IBInspectable var startingAngle : CGFloat = CGFloat(-M_PI_2) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var borderThickness : CGFloat = 2 {
        didSet {
            borderLayer.lineWidth = self.borderThickness
            self.setNeedsLayout()
        }
    }
    
    private func getSlice(center : CGPoint, radius : CGFloat, startAngle : CGFloat, endAngle : CGFloat) -> CGPathRef {
        let arc = UIBezierPath()
        arc.moveToPoint(center)
        arc.addArcWithCenter(center, radius: radius, startAngle: startAngle + startingAngle, endAngle: endAngle + startingAngle, clockwise: true)
        arc.fill()
        return arc.CGPath
    }
    
    
    private let two_pi = CGFloat(2 * M_PI)
    private func animateSlice() -> CAShapeLayer {
        let center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))
        var diameter = self.bounds.size.width
        if(self.bounds.size.height < diameter) {
            diameter = self.bounds.size.height
        }
        let radius = diameter / 2.0
        /*
        let initialSlice = getSlice(center, radius: radius, startAngle: 0, endAngle: self.prevProgress * two_pi)
        let targetSlice = getSlice(center, radius: radius, startAngle: self.prevProgress * two_pi, endAngle: self.progress * two_pi)
        

        let slice = CAShapeLayer()
        slice.fillColor = self.tintColor.CGColor
        slice.path = initialSlice
        let anim = CABasicAnimation(keyPath: "strokeEnd")
        anim.duration = 0.125
        anim.fromValue = initialSlice
        anim.toValue = targetSlice
        anim.removedOnCompletion = false
        anim.fillMode = kCAFillModeForwards
        return slice
        */
        let slicePath = getSlice(center, radius: radius, startAngle: 0, endAngle: self.progress * two_pi)
        let slice = CAShapeLayer()
        slice.fillColor = self.tintColor.CGColor
        slice.path = slicePath
        let anim = CABasicAnimation(keyPath: "opcity")
        anim.duration = 0.25
        anim.fromValue = 0
        //anim.toValue = self.progress * two_pi
        anim.toValue = 1.0
        anim.removedOnCompletion = false
        anim.fillMode = kCAFillModeForwards
        return slice
    }
    
    override public func layoutSubviews() {
    super.layoutSubviews()
        let roundLayer = CAShapeLayer()
        let circularMask : UIBezierPath = UIBezierPath(ovalInRect: bounds)
        roundLayer.path = circularMask.CGPath
        layer.mask = roundLayer

        let circle = UIBezierPath(ovalInRect: self.bounds)
        circle.stroke()
        self.borderLayer.path = circle.CGPath
        self.progressLayer?.addSublayer(animateSlice())
    }
    
    
}
