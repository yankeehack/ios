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
    
    var operandStack = Array<Double>()
    var lastOp: String = ""
    
    func store (){
        if typingInt {
            typingInt = false
            operandStack.append(displayValue)
        }
    }
    
    var displayValue: Double {
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
        if typingInt {
            calculate(lastOp)
            store()
        }
        lastOp = operand
    }
    
    func calculate(operation: String) {
        switch operation {
            case "×": performFunction{(op1, op2) in op2 * op1}
            case "÷": performFunction{(op1, op2) in op2 / op1}
            case "+": performFunction{(op1, op2) in op2 + op1}
            case "−": performFunction{(op1, op2) in op2 - op1}
            case "√": performFunction{(op1) in sqrt(op1)}
        default: break
        }
    }
    
    func performFunction(operation: (Double, Double) -> Double){
        if operandStack.count == 1 {
            operandStack.append(operation(operandStack.removeLast(), displayValue))
            displayValue = operandStack.last!
        }
    }
    func performFunction(operation: (Double) -> Double){
        if operandStack.count == 0 {
            operandStack.append(operation(displayValue))
            displayValue = operandStack.last!
        }
    }
    
    
    
    
}

