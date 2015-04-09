//
//  ViewController.swift
//  calculator
//
//  Created by Yanqing Zhu on 4/2/15.
//  Copyright (c) 2015 Yanqing Zhu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        var leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        leftSwipe.direction = .Left
        
        view.addGestureRecognizer(leftSwipe)
        
    }
    
    func handleSwipes(sender: UISwipeGestureRecognizer){
        if countElements(display.text!) > 1 {
            display.text = display.text!.substringToIndex(display.text!.endIndex.predecessor())
        }
        else {
            displayValue = 0
        }
    }
    
    @IBOutlet weak var display: UILabel!
    var typingInt = false
    var brain = CalculatorBrain()
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        println("digit = \(digit)")
        logHistory(digit)
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
    @IBOutlet weak var history: UITextView!
    
    func logHistory(s: String){
        history.text = history.text + s + "\n"
    }
    
    
    @IBAction func operate(sender: UIButton) {
        let operand = sender.currentTitle!
        logHistory(operand)
        if typingInt {
            calculate(lastOp)
            store()
        }
        lastOp = operand
    }
    
    @IBAction func clear() {
        operandStack.removeAll(keepCapacity: false)
        history.text = ""
        typingInt = false
        displayValue = 0
    }
    
    
    
    
    
    
}

