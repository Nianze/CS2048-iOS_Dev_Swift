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

