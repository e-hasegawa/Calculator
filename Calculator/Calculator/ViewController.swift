//
//  ViewController.swift
//  Calculator
//  
//  Created by e.hasegawa on 2022/07/05.
//  

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var calculatorLabel: UILabel!
    
    var valuePresent = false
    var decimalPoint = false
    var formulaArray = [String]()
    
    @IBAction func numberButtons(_ sender: UIButton) {
        let number = calculatorLabel.text!
        if valuePresent == false {
            calculatorLabel.text = ""
            calculatorLabel.text = String(sender.tag)
            valuePresent = true
        } else {
            if decimalPoint == true {
                if calculatorLabel.text!.count < 10 {
                    calculatorLabel.text = number + String(sender.tag)
                }
            } else {
                if calculatorLabel.text!.count < 9 {
                    calculatorLabel.text = number + String(sender.tag)
                }
            }
        }
    }
    
    @IBAction func allClear(_ sender: Any) {
        calculatorLabel.text = "0"
        formulaArray.removeAll()
        valuePresent = false
        decimalPoint = false
    }
    
    @IBAction func decimal(_ sender: Any) {
        if decimalPoint == false {
            if valuePresent == false {
                calculatorLabel.text = "0."
                valuePresent = true
            } else {
                calculatorLabel.text = calculatorLabel.text! + "."
            }
            decimalPoint = true
        }
    }
    
    @IBAction func plusMinus(_ sender: Any) {
        let turnedValue = Double(calculatorLabel.text!)! * -1
        let formattedValue = formatValue(value: turnedValue)
        calculatorLabel.text = formattedValue
    }
    
    @IBAction func percent(_ sender: Any) {
        let percentValue = Double(calculatorLabel.text!)! * 0.01
        let formattedValue = formatValue(value: percentValue)
        calculatorLabel.text = formattedValue
    }
    
    @IBAction func plus(_ sender: Any) {
        operate(symbol: "+")
    }
    
    @IBAction func minus(_ sender: Any) {
        operate(symbol: "-")
    }
    
    @IBAction func times(_ sender: Any) {
        operate(symbol: "*")
    }
    
    @IBAction func divide(_ sender: Any) {
        if decimalPoint == true {
            operate(symbol: "/")
        } else {
            operate(symbol: ".0/")
        }
    }
    
    @IBAction func equal(_ sender: Any) {
        formulaArray.append(calculatorLabel.text!)
        calculate()
        formulaArray.removeAll()
        valuePresent = true
        decimalPoint = true
    }
    
    func operate(symbol: String) {
        if valuePresent == true {
            formulaArray.append(calculatorLabel.text!)
            calculate()
            formulaArray.append(symbol)
            valuePresent = false
            decimalPoint = false
        }
    }
    
    func calculate() {
        let formula = formulaArray.joined(separator: "")
        let expression = NSExpression(format: formula)
        var resultDouble = 0.0
        if let answer = expression.expressionValue(with: nil, context: nil) as? Double {
            resultDouble = answer
        }
        let resultString = formatValue(value: resultDouble)
        calculatorLabel.text = resultString
    }
    
    func formatValue(value: Double) -> String {
        if value.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", value)
        } else {
            return String(value)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
}

