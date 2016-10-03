//
//  ViewController.swift
//  GraphingCalculator
//
//  Created by Daniel Hauagge on 9/15/16.
//  Copyright © 2016 CS2048 Instructor. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, FunctionPlottingViewDelegate {
    
    @IBOutlet weak var expressionEntryTextField: UITextField!
    @IBOutlet weak var plottingView: FunctionPlottingView!

    override func viewDidLoad() {
        super.viewDidLoad()
        expressionEntryTextField.delegate = self
        plottingView.delegate = self
    }
    
    @IBAction func tapGestureRecognized(sender: UITapGestureRecognizer) {
        let tapLocation = sender.locationInView(plottingView)
        plottingView.crosshairLoc = tapLocation
        plottingView.setNeedsDisplay()
    }

    @IBAction func panGestureRecognized(sender: UIPanGestureRecognizer) {
        //print("called panGestureRecognized")
        if sender.state == UIGestureRecognizerState.Began {
            plottingView.concatTrans()
        }
        plottingView.transFactor = sender.translationInView(plottingView)
        plottingView.setNeedsDisplay()
        if sender.state == UIGestureRecognizerState.Ended {
            plottingView.concatTrans()
        }
    }
    
    
    @IBAction func longPressGestureRecognized(sender: UILongPressGestureRecognizer) {
        print("called longPressGestureRecognized")
        if sender.state == UIGestureRecognizerState.Ended {
            plottingView.crosshairSwitch.toggle()
        }
        print(plottingView.crosshairSwitch)
        plottingView.setNeedsDisplay()
    }
    
    @IBAction func pinchGestureRecognized(sender: UIPinchGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.Began {
            plottingView.concatScale()
        }
        plottingView.scaleFactor = sender.scale
        plottingView.setNeedsDisplay()
    }
    
    // MARK: - UITextFieldDelegate methods
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("called textFieldShouldReturn")
        expressionEntryTextField.resignFirstResponder()
        plottingView.setNeedsDisplay() // Forces redraw!
        return false
    }
    
    
    // MARK: - Plotting View Delegate Protocol
    func functionToPlot() -> (Double -> Double)? {
        
        if expressionEntryTextField.text == nil {
            return nil
        }
                
        var parsedExpr : NSExpression?
        do {
            try TryCatch.tryBlock {
                parsedExpr =
                    NSExpression(format: self.expressionEntryTextField.text!)
            }
        } catch {
            return nil
        }
        

        func x2(x: Double) -> Double {
            let vars = ["x": x]
            return parsedExpr!.expressionValueWithObject(vars,
                                                         context: nil).doubleValue
        }
        
        return x2
    }
}

