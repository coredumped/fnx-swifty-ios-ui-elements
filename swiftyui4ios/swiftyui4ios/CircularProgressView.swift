//
//  CircularProgressView.swift
//  swiftyui4ios
//
//  Created by Juan Guerrero on 7/28/15.
//  Copyright (c) 2015 fn(x) Software. All rights reserved.
//

import UIKit

class CircularProgressView: UIView {
    
    private var progressLayer : CAShapeLayer?
    
    var progress : CGFloat = 0 {
        willSet(v) {
            if v > 1.0 || v < 0.0 {
                fatalError("progress must be a value between 0 and 1")
            }
        }
        didSet {
            dispatch_async(dispatch_get_main_queue(), {
                self.updateProgress()
            })
        }
    }

    private func updateProgress() {
        let center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))
        var radius = self.bounds.size.width
        if(self.bounds.size.height < radius) {
            radius = self.bounds.size.height
        }
        radius = radius / 2.0
        let arc = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0.0, endAngle: self.progress * CGFloat(M_PI) * 2, clockwise: true)
        if progressLayer == nil {
            progressLayer = CAShapeLayer()
            self.layer.addSublayer(progressLayer)
        }
        arc.fill()
        progressLayer?.path = arc.CGPath
        progressLayer?.fillColor = self.tintColor.CGColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let circle = UIBezierPath(ovalInRect: self.bounds)
        circle.stroke()
        let borderLayer = CAShapeLayer()
        borderLayer.strokeColor = tintColor.CGColor
        borderLayer.lineWidth = 2.0
        self.layer.addSublayer(layer)
    }

}
