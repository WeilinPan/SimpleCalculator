//
//  ViewController.swift
//  SimpleCalculator
//
//  Created by APAN on 2019/9/14.
//  Copyright © 2019 APAN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var numberOnScreen:Double = 0                   // 畫面上數字
    var previousNumberOnScreen:Double = 0           // 運算前畫面上數字
    var performingMath:Bool = false                 // 運算前畫面上數字
    var operation = "none"                          // 記錄要使用的運算
    var newCalculation = true                       // 是否為新的計算
    
    // 將狀態列顯示成light style
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //  顯示螢幕內容（label）的IBOutlet
    @IBOutlet weak var label: UILabel!
    
    // 函式，判斷數值是否為整數，同時判斷為循環小數時控制顯示位數
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
    
    // 數字鍵們的IBAction
    @IBAction func numbers(_ sender: UIButton) {
        // 利用button的tag值得到對應的數值
        let inputNumber = sender.tag

        if (label.text != nil) {
            // 判斷是否為新的計算
            if (newCalculation == true) {
                label.text = "\(inputNumber)"
                newCalculation = false
            } else {
                // 由目前label顯示內容判斷是否是要輸入多為數值
                if (label.text == "0" || label.text == "+" || label.text == "-" || label.text == "x" || label.text == "/") {
                    label.text = "\(inputNumber)"
                }else {
                    label.text = label.text! + "\(inputNumber)"
                }
            }
            numberOnScreen = Double(label.text!) ?? 0       // Double可能轉型失敗～失敗則傳0，成功則傳轉型後的值
        }
    }
    
    // 清除的IBAction
    @IBAction func clearButton(_ sender: UIButton) {
        // 將一切回歸初始狀態
        label.text = "0"
        numberOnScreen = 0
        previousNumberOnScreen = 0
        performingMath = false
        operation = "none"
        newCalculation = true
    }
    
    // 加法的IBAction
    @IBAction func add(_ sender: UIButton) {
        label.text = "+"
        operation = "add"
        performingMath = true
        previousNumberOnScreen = numberOnScreen         // 將原本的數值指派為前一個數值
    }
    
    // 減法的IBAction
    @IBAction func subtract(_ sender: UIButton) {
        label.text = "-"
        operation = "subtract"
        performingMath = true
        previousNumberOnScreen = numberOnScreen         // 將原本的數值指派為前一個數值
    }
    
    // 乘法的IBAction
    @IBAction func multiply(_ sender: UIButton) {
        label.text = "x"
        operation = "multiply"
        performingMath = true
        previousNumberOnScreen = numberOnScreen         // 將原本的數值指派為前一個數值
    }
    
    // 除法的IBAction
    @IBAction func divide(_ sender: UIButton) {
        label.text = "/"
        operation = "divide"
        performingMath = true
        previousNumberOnScreen = numberOnScreen         // 將原本的數值指派為前一個數值
    }
    
    //  負號的IBAction
    @IBAction func negativeButton(_ sender: UIButton) {
        numberOnScreen = (numberOnScreen * -1)      // 將螢幕數值乘以-1
        checkTheNumber(number: numberOnScreen)
    }
    
    // 百分比的IBAction
    @IBAction func percentageButton(_ sender: UIButton) {
        numberOnScreen = (numberOnScreen / 100)      // 將螢幕數值除以100
        checkTheNumber(number: numberOnScreen)
        
    }
    
    // 小數點的IBAction
    @IBAction func dutButton(_ sender: UIButton) {
        if (label.text != nil) {
            // 判斷是否為新的計算
            if (newCalculation == true) {
                label.text = "0."               // 避免使用者忘記輸入0
                newCalculation = false          // 設為false才可正常產生零點幾的數值
            } else {
                label.text = label.text! + "."
            }
        }
    }
    
    // 等號的IBAction
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
                    label.text = "錯誤"       //  參考iphone計算機顯示結果
                } else {
                    numberOnScreen = (previousNumberOnScreen / numberOnScreen)
                    checkTheNumber(number: numberOnScreen)
                }
            } else if (operation == "none") {
                label.text = "0"
            }
            // 計算完畢後回歸初始狀態
            performingMath = false
            newCalculation = true
        }
    }
}


