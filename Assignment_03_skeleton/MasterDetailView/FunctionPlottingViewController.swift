//
//  FunctionPlottingViewController.swift
//  MasterDetailView
//
//  Created by Daniel Hauagge on 9/22/16.
//  Copyright © 2016 CS2048 Instructor. All rights reserved.
//

import UIKit

class FunctionPlottingViewController: UIViewController, UITextFieldDelegate, FunctionPlottingViewDelegate {
    @IBOutlet weak var expressionEntryTextField: UITextField!
    @IBOutlet weak var plottingView: FunctionPlottingView!
    
    var expressionFromSegue : String?
    var expressionIdxFromSegue : Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        expressionEntryTextField.delegate = self
        plottingView.delegate = self
        
        if expressionFromSegue != nil {
            expressionEntryTextField.text = expressionFromSegue
        }
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
        
        if let idx = expressionIdxFromSegue {
            let expr = expressionEntryTextField.text!
            
            FunctionsDB.sharedInstance.functions[idx] = expr
        }
        
        for expr in FunctionsDB.sharedInstance.functions {
            print("-> \(expr)")
        }
        
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
