//
//  ViewController.swift
//  Calculator
//
//  Created by lnz on 9/10/16.
//  Copyright © 2016 lnz. All rights reserved.
//

import UIKit

enum Operator{
    case addition
    case substraction
    case multiplication
    case division
    case reminder
    case percentage
    case allclear
    case none
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
    var opt: Operator = Operator.none

    override func viewDidLoad() {
        super.viewDidLoad()
        numberDisplayLabel.adjustsFontSizeToFitWidth = true
    }
    
    func digitUpdate(_ keyValue: String) {
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
    
    func precisionCount(_ result: Double, keyValue: String) {
        if result.truncatingRemainder(dividingBy: 1) != 0 {
            counter = String(result).characters.split(separator: ".")[1].count
        } else {
            counter = 0
        }
        if decimal && keyValue == "0" {
            counter += zeroesAfterDecimal
        }
    }
    
    
    func showResult(_ result: Double) {
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
        if decimal && !numberDisplayLabel.text!.contains(".") {
            numberDisplayLabel.text! += "."
        }
    }
    
    func calculate(_ num1: Double, num2: Double, opt: Operator) {
        switch opt {
        case Operator.addition:
            result = num1 + num2
            break
        case Operator.substraction:
            result = num1 - num2
            break
        case Operator.multiplication:
            result = num1 * num2
            break
        case Operator.division:
            if num2 != 0.0 {
                result = num1 / num2
                break
            } else {
                isError = true
                break
            }
        case Operator.none:
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
    
    
    @IBAction func numpadButtonPressed(_ sender: UIButton) {
        showBuffer = false
        if highlightTeg != 0 {
            let button = self.view.viewWithTag(highlightTeg) as? UIButton
            button?.isSelected = false
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
            opt = Operator.addition
            showBuffer = true
            sender.isSelected = true
            highlightTeg = 1
            break
        case "－":
            update()
            opt = Operator.substraction
            showBuffer = true
            sender.isSelected = true
            highlightTeg = 2
            break
        case "×":
            update()
            opt = Operator.multiplication
            showBuffer = true
            sender.isSelected = true
            highlightTeg = 3
            break
        case "÷":
            update()
            opt = Operator.division
            showBuffer = true
            sender.isSelected = true
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
            opt = Operator.none
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

