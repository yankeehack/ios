//
//  ViewController.swift
//  calculator
//
//  Created by Yanqing Zhu on 4/2/15.
//  Copyright (c) 2015 Yanqing Zhu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    var typingInt = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        println("digit = \(digit)")
        if typingInt {display.text = display.text!+digit}
        else {
            display.text = digit
            typingInt = true
        }
    }
    
    var opperandStack = Array<Double>()
    
    @IBAction func enter() {
        if typingInt {
            typingInt = false
            opperandStack.append(displayValue)
        }
    }
    
    
    var displayValue: Double{
        get{
           return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            typingInt = false
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        let operand = sender.currentTitle!
        if typingInt {enter()}
        switch operand {
        case "×": performFunction{(op1, op2) in op2 * op1}
        case "÷": performFunction{(op1, op2) in op2 / op1}
        case "+": performFunction{(op1, op2) in op2 + op1}
        case "−": performFunction{(op1, op2) in op2 - op1}
        default: break
        }
    }
    
    func performFunction(operation: (Double, Double) -> Double){
        if opperandStack.count >= 2{
            displayValue = operation(opperandStack.removeLast(), opperandStack.removeLast())
            enter()
        }
    }
    
    
    
    
}

