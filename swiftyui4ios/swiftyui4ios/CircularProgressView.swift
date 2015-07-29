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
    
    private var progressLayer : CAShapeLayer?
    private var borderLayer : CAShapeLayer?
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.contentMode = .Redraw
        self.backgroundColor = UIColor.clearColor()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentMode = .Redraw
        self.backgroundColor = UIColor.clearColor()
    }
    
    public override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        updateProgress()
    }
    
    public var progress : CGFloat = 0 {
        willSet(v) {
            if v > 1.0 || v < 0.0 {
                fatalError(String(format: "progress must be a value between 0 and 1, value was %lf", v))
            }
        }
        didSet {
            dispatch_async(dispatch_get_main_queue(), {
                //self.updateProgress()
                self.setNeedsDisplay()
                if(self.progress == 0 || self.progress >= 1) {
                    self.hidden = true
                }
                else {
                    self.hidden = false
                }

            })
        }
    }

    private func updateProgress() {
        let ctx = UIGraphicsGetCurrentContext()
        CGContextSaveGState(ctx)
        if(borderLayer == nil) {
            borderLayer = CAShapeLayer()
            //backgroundColor = UIColor.clearColor()
            let circle = UIBezierPath(ovalInRect: self.bounds)
            circle.stroke()
            borderLayer?.fillColor = UIColor.clearColor().CGColor
            borderLayer?.strokeColor = tintColor.CGColor
            borderLayer?.lineWidth = 2.0
            borderLayer?.path = circle.CGPath
            self.layer.addSublayer(borderLayer!)
        }

        
        let center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))
        var radius = self.bounds.size.width
        if(self.bounds.size.height < radius) {
            radius = self.bounds.size.height
        }
        radius = radius / 2.0
        let arc = UIBezierPath()
        arc.moveToPoint(center)
        arc.addArcWithCenter(center, radius: radius, startAngle: 0.0, endAngle: self.progress * CGFloat(M_PI) * 2, clockwise: true)
        if progressLayer == nil {
            progressLayer = CAShapeLayer()
            self.layer.addSublayer(progressLayer)
        }
        arc.fill()
        progressLayer?.path = arc.CGPath
        progressLayer?.fillColor = self.tintColor.CGColor
        CGContextRestoreGState(ctx)
    }
    /*
    override public func layoutSubviews() {
        super.layoutSubviews()
    }
    */

}
