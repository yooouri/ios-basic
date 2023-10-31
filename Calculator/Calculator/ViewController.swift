//
//  ViewController.swift
//  Calculator
//
//  Created by YURI KIM on 2023/10/31.
//

import UIKit
enum Operation {
    case Add
    case Subtract
    case Multiply
    case Divide
    case Unknown
}
class ViewController: UIViewController {

    @IBOutlet weak var numberOutputLabel: UILabel!
    
    var displayNumber = "" //라벨에 보여질
    var firstOperand = "" //첫번째 피연산자
    var secondOperand = "" //새로 입렵된(두번째 피연산자)
    var result = ""
    var currentOperation: Operation = .Unknown
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tapNumberButton(_ sender: UIButton) {
        guard let numberValue =  sender.title(for: .normal) else { return }
        if self.displayNumber.count < 9 {
            self.displayNumber += numberValue
            self.numberOutputLabel.text = displayNumber
        }
    }
    
    @IBAction func tapClearButton(_ sender: UIButton) {
        self.displayNumber = ""
        self.firstOperand = ""
        self.secondOperand = ""
        self.result = ""
        self.currentOperation = .Unknown
        self.numberOutputLabel.text = "0"
    }
    
    @IBAction func tapDotButton(_ sender: UIButton) {
        if self.displayNumber.count < 8, !self.displayNumber.contains(".") {
            self.displayNumber += self.displayNumber.isEmpty ? "0." : "."
            self.numberOutputLabel.text = self.displayNumber
        }
    }
    
    @IBAction func tapDivideButton(_ sender: UIButton) {
        self.operation(.Divide)
    }
    
    
    @IBAction func tapMultiplyButton(_ sender: UIButton) {
        self.operation(.Multiply)
    }
    
    @IBAction func tapSubtractButton(_ sender: UIButton) {
        self.operation(.Subtract)
    }
    
    @IBAction func tapAddButton(_ sender: UIButton) {
        self.operation(.Add)
        
    }
    
    @IBAction func tapEqualButton(_ sender: UIButton) {
        self.operation(self.currentOperation)
    }
    
    func operation(_ operation: Operation) {
        //누적 연산
        if self.currentOperation != .Unknown {
            if !self.displayNumber.isEmpty {
                self.secondOperand = self.displayNumber
                self.displayNumber = ""
                
                guard let firstOperand = Double(self.firstOperand) else { return }
                guard let secondOperand = Double(self.secondOperand) else { return }
                let tmp = calculation(firstOperand, secondOperand)
                self.firstOperand = tmp
                self.numberOutputLabel.text = tmp
                self.currentOperation = operation
            }
        }else {
            //equal
            self.firstOperand = self.displayNumber
            self.currentOperation = operation
            self.displayNumber = ""
        }
    }
 
    func calculation(_ first: Double, _ second: Double) -> String {
        switch self.currentOperation {
        case .Add:
            self.result = "\(first + second)"
            break
            
        case .Subtract:
            self.result = "\(first - second)"
            break
            
        case .Multiply:
            self.result = "\(first * second)"
            break
            
        case .Divide:
            self.result = "\(first / second)"
            break
            
        default:
            break
        
        }
        
        //1로 나눈 나머지가 0이면 Int변환(소수점 제거)
        if let result = Double(self.result), result.truncatingRemainder(dividingBy: 1) == 0{
            self.result = "\(Int(result))"
        }
        
        return self.result
        
    }
}

