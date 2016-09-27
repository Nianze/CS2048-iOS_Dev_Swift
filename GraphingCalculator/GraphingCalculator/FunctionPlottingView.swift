//
//  FunctionPlottingView.swift
//  GraphingCalculator
//
//  Created by Daniel Hauagge on 9/17/16.
//  Copyright © 2016 CS2048 Instructor. All rights reserved.
//

import UIKit

protocol FunctionPlottingViewDelegate {
    func functionToPlot() -> (Double -> Double)?
}

enum OnOffSwitch {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
        print("Toggled!!")
    }
}

class FunctionPlottingView: UIView {
    
    var delegate : FunctionPlottingViewDelegate?

    var crosshairLoc : CGPoint? = CGPoint(x: 50, y: 50)
    
    var crosshairSwitch = OnOffSwitch.on
    
    var minX : Double = -1.0, maxX : Double = 1.0, minY : Double = -1.0, maxY : Double = 1.0
    
    var transFactor : CGPoint = CGPoint(x: 0, y: 0)
    var transPath : CGAffineTransform = CGAffineTransformIdentity
    
    var scaleFactor: CGFloat = 1.0
    var scaleMatrix : CGAffineTransform = CGAffineTransformIdentity
    
    func translatePath(path : UIBezierPath) {
        path.applyTransform(CGAffineTransformConcat(transPath, CGAffineTransformTranslate(self.transform, transFactor.x, transFactor.y)))
    }
    
    func concatTrans() {
        transPath = CGAffineTransformConcat(transPath, CGAffineTransformTranslate(self.transform, transFactor.x, transFactor.y))
    }
    
    func scalePath(path : UIBezierPath) {
        path.applyTransform(CGAffineTransformConcat(scaleMatrix, CGAffineTransformScale(self.transform, scaleFactor, scaleFactor)))
    }
    
    func concatScale() {
        scaleMatrix = CGAffineTransformConcat(scaleMatrix, CGAffineTransformScale(self.transform, scaleFactor, scaleFactor))
    }
    
    func updateRange(rect: CGRect) {
        let inverse = CGAffineTransformInvert(CGAffineTransformConcat(transPath, scaleMatrix))
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 0.0, y: 0.0))
        path.applyTransform(inverse)
        minX = Double(path.currentPoint.x)
        minY = Double(path.currentPoint.y)
        path.moveToPoint(CGPoint(x: rect.maxX, y: rect.maxY))
        path.applyTransform(inverse)
        maxX = Double(path.currentPoint.x)
        maxY = Double(path.currentPoint.y)
        print(minX)
        print(maxX)
        print(minY)
        print(maxY)
    }
    
    func drawCrosshair(rect: CGRect) {
        if crosshairLoc == nil {
            return
        }
        
        if crosshairSwitch == OnOffSwitch.off {
            return
        }
        
        let inverse = CGAffineTransformInvert(CGAffineTransformConcat(transPath, scaleMatrix))
        let path = UIBezierPath()
        path.moveToPoint(crosshairLoc!)
        path.applyTransform(inverse)
        let point = path.currentPoint
        var funcX : CGFloat = point.x
        var funcY : CGFloat = point.y
        var newY : CGFloat = point.y
        let scale = CGFloat((maxX - minX) / 2.0)
        
        // Change the screen space to function space
        if let function = delegate?.functionToPlot() {
            funcX = (point.x - rect.midX) / scale
            funcY = CGFloat(function(Double(funcX)))
            newY = funcY * (-scale) + rect.midY
        } else {
            return
        }

        // X Axis
        path.moveToPoint(CGPoint(x: CGFloat(minX), y: newY))
        path.addLineToPoint(CGPoint(x: CGFloat(maxX), y: newY))
        
        // Y Axis
        path.moveToPoint(CGPoint(x: point.x, y: CGFloat(minY)))
        path.addLineToPoint(CGPoint(x: point.x, y: CGFloat(maxY)))
        
        // transform
        scalePath(path)
        translatePath(path)
        
        UIColor.lightGrayColor().setStroke()
        path.stroke() // <- Does the actual drawing!!!
    
        path.moveToPoint(CGPoint(x: point.x, y: newY))
        scalePath(path)
        translatePath(path)
        let label = NSString(format: "(x:%.1f, y:%.1f)", funcX, funcY)
        label.drawAtPoint(path.currentPoint, withAttributes: nil)
    }
    
    func drawFunction(rect: CGRect) {
        if delegate == nil {
            return
        }
        
        let f = delegate?.functionToPlot()
        if f == nil {
            return
        }
        
        let scale = (maxX - minX) / 2.0 // relation between scale and pinch factor?
        var prevP : CGPoint?
        let path = UIBezierPath()
        let funcMinX = (minX - Double(rect.midX)) / scale
        let funcMaxX = (maxX - Double(rect.midX)) / scale
        
        for x in funcMinX.stride(to: funcMaxX, by: 0.01) {
            let y = f!(x)
            var p = CGPoint(x:x, y:y)
            
            if x < 0 && ((x + 0.01) > 0) {
                let round = Int(x)
                if !(f!(Double(round)).isNormal) {
                    prevP = nil
                    continue
                }
            }
            
            if y.isNormal || y.isZero {
                p.x *= CGFloat(scale)
                p.y *= CGFloat(-scale)
                
                p.x += CGFloat(rect.midX)
                p.y += CGFloat(rect.midY)
                
                if prevP == nil {
                    path.moveToPoint(p)
                } else {
                    path.addLineToPoint(p)
                }
                prevP = p
            } else {
                prevP = nil
            }
        }
        UIColor.redColor().setStroke()
        
        // transform
        scalePath(path)
        translatePath(path)
        
        path.stroke()
    }
    
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath()
        updateRange(rect)
        
//        let midX = CGFloat((maxX + minX) / 2.0)
//        let midY = CGFloat((maxY + minY) / 2.0)
        // X Axis
        path.moveToPoint(CGPoint(x: CGFloat(minX), y: rect.midY))
        path.addLineToPoint(CGPoint(x: CGFloat(maxX), y: rect.midY))
        UIColor.blueColor().setStroke()
        
        // Y Axis
        path.moveToPoint(CGPoint(x: rect.midX, y: CGFloat(minY)))
        path.addLineToPoint(CGPoint(x: rect.midX, y: CGFloat(maxY)))
        UIColor.blueColor().setStroke()
        
        // transform
        scalePath(path)
        translatePath(path)
        
        path.stroke() // <- Does the actual drawing!!!
        
        // Draw the function
        drawFunction(rect)
        drawCrosshair(rect)
    }
    
    
}
