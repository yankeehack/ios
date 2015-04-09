//
//  CalculatorBrain.swift
//  calculator
//
//  Created by Yanqing Zhu on 4/7/15.
//  Copyright (c) 2015 Yanqing Zhu. All rights reserved.
//

import Foundation

class CalculatorBrain {
    private enum Op {
        case Operand(Double)
        case OneOperation(String, Double -> Double)
        case TwoOperation(String, (Double, Double) -> Double)
    }
    
    private var opStack = [Op]()
    private var knownOps = Dictionary<String, Op>()
    
    init (){
        knownOps["x"] = Op.TwoOperation("x", {(op1, op2) in op1 * op2})
        knownOps["÷"] = Op.TwoOperation("÷", {(op1, op2) in op1 / op2})
        knownOps["+"] = Op.TwoOperation("+", {(op1, op2) in op1 + op2})
        knownOps["−"] = Op.TwoOperation("−", {(op1, op2) in op1 - op2})
        knownOps["√"] = Op.OneOperation("√", sqrt)
    }
    
    
    
    private func evaluate(ops: [Op]) -> (result: Double?, ops: [Op]) {
        if !ops.isEmpty {
            var localOps = ops
            let op = localOps.removeLast()
            switch op {
            case .Operand(let operand):
                return (operand, localOps)
            case .OneOperation(_, let operation):
                let opEvaluation = evaluate(localOps)
                if let operand = opEvaluation.result {
                    return (operation(operand), opEvaluation.ops)
                }
            case .TwoOperation(_, let operation):
                let opEvaluationleft = evaluate(localOps)
                if let operandLeft = opEvaluationleft.result {
                    let opEvaluationRight = evaluate(localOps)
                    if let operandRight = opEvaluationRight.result {
                        return (operation(operandLeft, operandRight), opEvaluationRight.ops)
                    }
                }
            }
            
        }
        return (nil, ops)
    }
    
    func evaluate() -> Double? {
        let (result, ops) = evaluate(opStack)
        return result
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