//
//  ViewController.swift
//  Calculator
//
//  Created by lnz on 9/10/16.
//  Copyright © 2016 lnz. All rights reserved.
//

import UIKit

enum Operator{
    case Addition
    case Substraction
    case Multiplication
    case Division
    case Reminder
    case Percentage
    case Allclear
    case None
}

class ViewController: UIViewController {
    @IBOutlet weak var numberDisplayLabel: UILabel!
    
    var result: Double = 0.0
    var buffer: Double = 0.0
    var lastNum: Double = 0.0
    var counter: Int = 0
    var decimal: Bool = false
    var canReApply: Bool = false
    var showBuffer: Bool = false
    var isError: Bool = false
    var highlightTeg: Int = 0
    var zeroesAfterDecimal: Int = 0
    var opt: Operator = Operator.None

    override func viewDidLoad() {
        super.viewDidLoad()
        numberDisplayLabel.adjustsFontSizeToFitWidth = true
    }
    
    func digitUpdate(keyValue: String) {
        print(keyValue)
        if keyValue >= "0" && keyValue <= "9" {
            if result == 0.0 {
                counter = 0
                zeroesAfterDecimal = 0
            }
            showResult(result)
            result = Double(numberDisplayLabel.text! + keyValue)!
            if decimal && keyValue == "0" {
                zeroesAfterDecimal += 1
            } else {
                zeroesAfterDecimal = 0
            }
        }
    }
    
    func precisionCount(result: Double, keyValue: String) {
        if result % 1 != 0 {
            counter = String(result).characters.split(".")[1].count
        } else {
            counter = 0
        }
        if decimal && keyValue == "0" {
            counter += zeroesAfterDecimal
        }
    }
    
    
    func showResult(result: Double) {
        if isError {
            numberDisplayLabel.text! = "Error"
            return
        }
        var show: Double = result
        if show == -0.0 {
            show = 0.0
        }
        let cleanValue: String = String(format: "%.\(counter)f", show)
        numberDisplayLabel.text! = cleanValue
        if decimal && !numberDisplayLabel.text!.containsString(".") {
            numberDisplayLabel.text! += "."
        }
    }
    
    func calculate(num1: Double, num2: Double, opt: Operator) {
        switch opt {
        case Operator.Addition:
            result = num1 + num2
            break
        case Operator.Substraction:
            result = num1 - num2
            break
        case Operator.Multiplication:
            result = num1 * num2
            break
        case Operator.Division:
            if num2 != 0.0 {
                result = num1 / num2
                break
            } else {
                isError = true
                break
            }
        case Operator.None:
            break
        default:
            isError = true
        }
    }
    
    func update() {
        calculate(buffer, num2: result, opt: opt)
        buffer = result
        result = 0.0
        decimal = false
        lastNum = 0.0
        canReApply = false
    }
    
    
    @IBAction func numpadButtonPressed(sender: UIButton) {
        showBuffer = false
        if highlightTeg != 0 {
            let button = self.view.viewWithTag(highlightTeg) as? UIButton
            button?.selected = false
            highlightTeg = 0
        }

        let keyValue = sender.titleLabel!.text!
        switch keyValue {
        case ".":
            decimal = true
            canReApply = false
            break
        case "＋":
            update()
            opt = Operator.Addition
            showBuffer = true
            sender.selected = true
            highlightTeg = 1
            break
        case "－":
            update()
            opt = Operator.Substraction
            showBuffer = true
            sender.selected = true
            highlightTeg = 2
            break
        case "×":
            update()
            opt = Operator.Multiplication
            showBuffer = true
            sender.selected = true
            highlightTeg = 3
            break
        case "÷":
            update()
            opt = Operator.Division
            showBuffer = true
            sender.selected = true
            highlightTeg = 4
            break
        case "%":
            result *= 0.01
            canReApply = false
            break
        case "±":
            if (result != 0.0) {
                result *= -1.0
            }
            canReApply = false
            break
        case "AC":
            result = 0.0
            buffer = 0.0
            decimal = false
            counter = 0
            opt = Operator.None
            lastNum = 0.0
            canReApply = false
            isError = false
            zeroesAfterDecimal = 0
            break
        case "=":
            if canReApply {
                calculate(result, num2: lastNum, opt: opt)
                buffer = result
            } else {
                lastNum = result
                calculate(buffer, num2: result, opt: opt)
                buffer = result
                canReApply = true
            }
            break
        default:
            digitUpdate(keyValue)
        }
        
        if showBuffer {
            precisionCount(buffer, keyValue: keyValue)
            showResult(buffer)
        } else {
            precisionCount(result, keyValue: keyValue)
            showResult(result)
        }
        
        print("buffer is \(buffer)")
        print("result is \(result)")
        print("decimal is \(decimal)")
        print("opt is \(opt)")
        print("counter is \(counter)")
        print("canReApply is \(canReApply)")
        print("lasNum is \(lastNum)")
        print("zeroes after decimal point is \(zeroesAfterDecimal)")
        print("================================")
    }

}

