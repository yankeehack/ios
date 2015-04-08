//
//  CalculatorBrain.swift
//  calculator
//
//  Created by Yanqing Zhu on 4/7/15.
//  Copyright (c) 2015 Yanqing Zhu. All rights reserved.
//

import Foundation

class CalculatorBrain {
    enum Op {
        case Operand(Double)
        case OneOperation(String, Double -> Double)
        case TwoOperation(String, (Double, Double) -> Double)
    }
    
    var opStack = [Op]()
    var knownOps = Dictionary<String, Op>()
    
    init (){
        knownOps["x"] = Op.TwoOperation("x", {(op1, op2) in op1 * op2})
        knownOps["÷"] = Op.TwoOperation("÷", {(op1, op2) in op1 / op2})
        knownOps["+"] = Op.TwoOperation("+", {(op1, op2) in op1 + op2})
        knownOps["−"] = Op.TwoOperation("−", {(op1, op2) in op1 - op2})
        knownOps["√"] = Op.OneOperation("√", sqrt)
    }
    
    func pushOprand (operand: Double){
        opStack.append(Op.Operand(operand))
    }
    
    func performOperation(symbol: String){
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
    }
}