//
//  GradientView.swift
//  swiftyui4ios
//
//  Created by Juan Guerrero on 3/25/16.
//  Copyright © 2016 fn(x) Software. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {
    private var backingLayer : CGLayer?
    private var gradient : CGGradientRef?
    
    
    func drawGradient(ctx : CGContext, inRect rect : CGRect) {
        if backingLayer == nil {
            backingLayer = CGLayerCreateWithContext(ctx, rect.size, nil)
            let layerCtx = CGLayerGetContext(backingLayer)
            CGContextSaveGState(layerCtx)
            if gradient == nil {
                if middleColor != nil {
                    gradient = CGGradientCreateWithColors(
                        CGBitmapContextGetColorSpace(layerCtx),
                        [startColor!.CGColor, middleColor!.CGColor, endColor!.CGColor],
                        [startPosition, middlePosition, endPosition]
                    )
                }
                else {
                    gradient = CGGradientCreateWithColors(
                        CGBitmapContextGetColorSpace(layerCtx),
                        [startColor!.CGColor, endColor!.CGColor],
                        [startPosition, endPosition]
                    )
                }
            }
            if reversedFill {
                if gradientOrientation == .Vertical {
                    CGContextDrawLinearGradient(layerCtx, self.gradient, CGPoint(x: 0, y: rect.size.height), CGPoint(x: 0, y: 0), .DrawsAfterEndLocation)
                }
                else {
                    CGContextDrawLinearGradient(layerCtx, self.gradient, CGPoint(x: rect.size.width, y: 0), CGPoint(x: 0, y: 0), .DrawsAfterEndLocation)
                }
            }
            else {
                if gradientOrientation == .Vertical {
                    CGContextDrawLinearGradient(layerCtx, self.gradient, CGPoint(x: 0, y: 0), CGPoint(x: 0, y: rect.size.height), .DrawsAfterEndLocation)
                }
                else {
                    CGContextDrawLinearGradient(layerCtx, self.gradient, CGPoint(x: 0, y: 0), CGPoint(x: rect.size.width, y: 0), .DrawsAfterEndLocation)
                }
            }
            CGContextRestoreGState(layerCtx)
        }
        CGContextDrawLayerInRect(ctx, rect, backingLayer)
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        if startColor != nil && endColor != nil {
            let ctx = UIGraphicsGetCurrentContext()
            CGContextSaveGState(ctx)
            drawGradient(ctx!, inRect: rect)
            CGContextRestoreGState(ctx)
        }
    }
    
    @IBInspectable
    var startColor : UIColor? {
        didSet {
            gradient = nil
            backingLayer = nil
            self.setNeedsDisplay()
        }
    }
    @IBInspectable
    var startPosition : CGFloat = 0 {
        didSet {
            gradient = nil
            backingLayer = nil
            self.setNeedsDisplay()
        }
    }
    
    
    @IBInspectable
    var middleColor : UIColor? {
        didSet {
            gradient = nil
            backingLayer = nil
            self.setNeedsDisplay()
        }
    }
    @IBInspectable
    var middlePosition : CGFloat = 0.5 {
        didSet {
            gradient = nil
            backingLayer = nil
            self.setNeedsDisplay()
        }
    }
    
    
    @IBInspectable
    var endColor : UIColor? {
        didSet {
            gradient = nil
            backingLayer = nil
            self.setNeedsDisplay()
        }
    }
    @IBInspectable
    var endPosition : CGFloat = 1 {
        didSet {
            gradient = nil
            backingLayer = nil
            self.setNeedsDisplay()
        }
    }
    
    enum GradientOrientationTypes {
        case Vertical, Horizontal
    }
    
    @IBInspectable
    var gradientOrientation : GradientOrientationTypes = .Vertical {
        didSet {
            gradient = nil
            backingLayer = nil
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var reversedFill = false {
        didSet {
            gradient = nil
            backingLayer = nil
            self.setNeedsDisplay()
        }
    }
    
}
