//
//  CircularProgressView.swift
//  swiftyui4ios
//
//  Created by Juan Guerrero on 7/28/15.
//  Copyright (c) 2015 fn(x) Software. All rights reserved.
//

import UIKit

@IBDesignable
open class CircularProgressView: UIView {
    
    fileprivate var progressLayer : CALayer?
    fileprivate var borderLayer : CAShapeLayer = CAShapeLayer()
    
    fileprivate func setup() {
        //self.contentMode = .Redraw
        self.backgroundColor = UIColor.clear
        progressLayer = CALayer()
        self.layer.addSublayer(progressLayer!)
        
        
        
        //borderLayer = CAShapeLayer()
        
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = tintColor.cgColor
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
    
    
    fileprivate var prevProgress : CGFloat = 0
    
    @IBInspectable open var progress : CGFloat = 0.0 {
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
    
    fileprivate func getSlice(_ center : CGPoint, radius : CGFloat, startAngle : CGFloat, endAngle : CGFloat) -> CGPath {
        let arc = UIBezierPath()
        arc.move(to: center)
        arc.addArc(withCenter: center, radius: radius, startAngle: startAngle + startingAngle, endAngle: endAngle + startingAngle, clockwise: true)
        arc.fill()
        return arc.cgPath
    }
    
    
    fileprivate let two_pi = CGFloat(2 * M_PI)
    fileprivate func animateSlice() -> CAShapeLayer {
        let center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
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
        slice.fillColor = self.tintColor.cgColor
        slice.path = slicePath
        let anim = CABasicAnimation(keyPath: "opacity")
        anim.duration = 0.125
        anim.fromValue = 0
        //anim.toValue = self.progress * two_pi
        anim.toValue = 1.0
        anim.isRemovedOnCompletion = false
        anim.fillMode = kCAFillModeForwards
        return slice
    }
    
    override open func layoutSubviews() {
    super.layoutSubviews()
        let roundLayer = CAShapeLayer()
        let circularMask : UIBezierPath = UIBezierPath(ovalIn: bounds)
        roundLayer.path = circularMask.cgPath
        layer.mask = roundLayer

        let circle = UIBezierPath(ovalIn: self.bounds)
        circle.stroke()
        self.borderLayer.path = circle.cgPath
        self.progressLayer?.addSublayer(animateSlice())
    }
    
    
}
