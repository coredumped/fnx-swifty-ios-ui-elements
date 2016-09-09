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
    fileprivate var backingLayer : CGLayer?
    fileprivate var gradient : CGGradient?
    
    
    func drawGradient(_ ctx : CGContext, inRect rect : CGRect) {
        if backingLayer == nil {
            backingLayer = CGLayer(ctx, size: rect.size, auxiliaryInfo: nil)
            let layerCtx = backingLayer!.context
            layerCtx!.saveGState()
            if gradient == nil {
                if middleColor != nil {
                    gradient = CGGradient(
                        colorsSpace: layerCtx!.colorSpace,
                        colors: [startColor!.cgColor, middleColor!.cgColor, endColor!.cgColor] as NSArray,
                        locations: [startPosition, middlePosition, endPosition]
                    )
                }
                else {
                    gradient = CGGradient(
                        colorsSpace: layerCtx!.colorSpace,
                        colors: [startColor!.cgColor, endColor!.cgColor] as NSArray,
                        locations: [startPosition, endPosition]
                    )
                }
            }
            if reversedFill {
                if gradientOrientation == .vertical {
                    layerCtx!.drawLinearGradient(self.gradient!, start: CGPoint(x: 0, y: rect.size.height), end: CGPoint(x: 0, y: 0), options: .drawsAfterEndLocation)
                }
                else {
                    layerCtx!.drawLinearGradient(self.gradient!, start: CGPoint(x: rect.size.width, y: 0), end: CGPoint(x: 0, y: 0), options: .drawsAfterEndLocation)
                }
            }
            else {
                if gradientOrientation == .vertical {
                    layerCtx!.drawLinearGradient(self.gradient!, start: CGPoint(x: 0, y: 0), end: CGPoint(x: 0, y: rect.size.height), options: .drawsAfterEndLocation)
                }
                else {
                    layerCtx!.drawLinearGradient(self.gradient!, start: CGPoint(x: 0, y: 0), end: CGPoint(x: rect.size.width, y: 0), options: .drawsAfterEndLocation)
                }
            }
            layerCtx!.restoreGState()
        }
        //CGContextDrawLayerInRect(ctx, rect, backingLayer!)
        //draw(backingLayer!, in: ctx)
        ctx.draw(backingLayer!, in: rect)

    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if startColor != nil && endColor != nil {
            let ctx = UIGraphicsGetCurrentContext()
            ctx!.saveGState()
            drawGradient(ctx!, inRect: rect)
            ctx!.restoreGState()
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
        case vertical, horizontal
    }
    
    @IBInspectable
    var gradientOrientation : GradientOrientationTypes = .vertical {
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
