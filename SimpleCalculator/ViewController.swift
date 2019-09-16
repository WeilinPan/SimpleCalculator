//
//  ViewController.swift
//  SimpleCalculator
//
//  Created by APAN on 2019/9/14.
//  Copyright © 2019 APAN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var numberOnScreen:Double = 0
    var previousNumberOnScreen:Double = 0
    var performingMath:Bool = false
    var operation = "none"
    var newCalculation = true
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBOutlet weak var label: UILabel!
    
    func checkTheNumber (number:Double) {
        var okText:String   // 最後要顯示的字串
        if (floor(number) == number) {   // 判斷無條件捨去後始否與原數值相同
            okText = "\(Int(number))"
        } else {
            okText = "\(number)"
        }
        // 若字數大於等於9，則取前九個數字
        if (okText.count >= 9) {
            okText = String(okText.prefix(9))
        }
        label.text = okText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func numbers(_ sender: UIButton) {
        let inputNumber = sender.tag

        if (label.text != nil) {
            if (newCalculation == true) {
                label.text = "\(inputNumber)"
                newCalculation = false
            } else {
                if (label.text == "0" || label.text == "+" || label.text == "-" || label.text == "x" || label.text == "/") {
                    label.text = "\(inputNumber)"
                }else {
                    label.text = label.text! + "\(inputNumber)"
                }
            }
            numberOnScreen = Double(label.text!) ?? 0
        }
    }
    
    @IBAction func clearButton(_ sender: UIButton) {
        label.text = "0"
        numberOnScreen = 0
        previousNumberOnScreen = 0
        performingMath = false
        operation = "none"
        newCalculation = true
    }
    
    @IBAction func add(_ sender: UIButton) {
        label.text = "+"
        operation = "add"
        performingMath = true
        previousNumberOnScreen = numberOnScreen
    }
    
    
    @IBAction func subtract(_ sender: UIButton) {
        label.text = "-"
        operation = "subtract"
        performingMath = true
        previousNumberOnScreen = numberOnScreen
    }
    
    
    @IBAction func multiply(_ sender: UIButton) {
        label.text = "x"
        operation = "multiply"
        performingMath = true
        previousNumberOnScreen = numberOnScreen
    }
    
    
    @IBAction func divide(_ sender: UIButton) {
        label.text = "/"
        operation = "divide"
        performingMath = true
        previousNumberOnScreen = numberOnScreen
    }
    
    
    @IBAction func negativeButton(_ sender: UIButton) {
        numberOnScreen = (numberOnScreen * -1)
        checkTheNumber(number: numberOnScreen)
    }
    
    
    @IBAction func percentageButton(_ sender: UIButton) {
        numberOnScreen = (numberOnScreen / 100)
        checkTheNumber(number: numberOnScreen)
        
    }
    
    
    @IBAction func dutButton(_ sender: UIButton) {
        if (label.text != nil) {
            if (newCalculation == true) {
                label.text = "0."
                newCalculation = false
            } else {
                label.text = label.text! + "."
            }
        }
    }
    
    
    @IBAction func answer(_ sender: UIButton) {
        if (performingMath == true) {
            if (operation == "add") {
                numberOnScreen = (previousNumberOnScreen + numberOnScreen)
                checkTheNumber(number: numberOnScreen)
            } else if (operation == "subtract") {
                numberOnScreen = (previousNumberOnScreen - numberOnScreen)
                checkTheNumber(number: numberOnScreen)
            } else if (operation == "multiply") {
                numberOnScreen = (previousNumberOnScreen * numberOnScreen)
                checkTheNumber(number: numberOnScreen)
            } else if (operation == "divide") {
                // 判斷除數是否為零
                if (numberOnScreen == 0) {
                    label.text = "錯誤"
                } else {
                    numberOnScreen = (previousNumberOnScreen / numberOnScreen)
                    checkTheNumber(number: numberOnScreen)
                }
            } else if (operation == "none") {
                label.text = "0"
            }
            performingMath = false
            newCalculation = true
        }
    }
}


