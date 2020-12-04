//
//  ViewController.swift
//  L4 More UIKit
//
//  Created by Xuedan Fillmore on 10/6/20.
//  Copyright © 2020 Xuedan Fillmore. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    var points:UInt8 = 0
    @IBOutlet weak var maxRangeLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var rangeStep: UIStepper!
    @IBOutlet weak var guessInput: UITextField!
    
    override func viewDidLoad() {
        guessInput.delegate = self
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        rangeStep.value = 100
    }
    
    @IBAction func updateRange(_ sender: UIStepper) {
        maxRangeLabel.text = String(format: "%.0f", sender.value)
    }
    
    @IBAction func guessSubmit(_ sender: UIButton) {
        // hide keyboard
        dismissKeyboard()
        
        // generate random number within specified range
        let randVal : UInt32 = UInt32(arc4random_uniform(UInt32(rangeStep.value)+1))
        var message_ : String = ""
        
        // read value from guessInput and check for numeric validity
        var guessVal:UInt32 = 0
        if (guessInput.text!.isEmpty) {
            message_ = "You didn't provide a guess."
        }
        else if (Int32(guessInput.text!)! < 0 || Int32(guessInput.text!)! > Int32(rangeStep.value)) {
            message_ = "Your guess wasn't within range. The number was " + String(randVal)
        }
            
        // compare guessInput with random number and determine points
        else {
            guessVal = UInt32(guessInput.text!)!
            if (guessVal == randVal) {
                message_ = "Congratulations, you guessed the right number."
                points += 1
                pointsLabel.text = "Points: " + String(points)
            }
            else if (guessVal > randVal) {
                message_ = "Your guess was too high. The number was " + String(randVal)
            }
            else { // guessVal < randVal
                message_ = "Your guess was too low. The number was " + String(randVal)
            }
        }
        
        // create alert to inform user of result
        let alert = UIAlertController(title: "Result", message: message_, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okAction)
//        Alert(title: "Result", message: message_)
        present(alert, animated: true, completion: nil)
    }
    
    func dismissKeyboard() {
        // https://www.hackingwithswift.com/forums/swiftui/textfield-dismiss-keyboard-clear-button/240
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func hideKeyboard(_ sender: Any) {
        dismissKeyboard()
    }
    
    // good practice consideration
    // textInput = String(bytes: FileHandle.standardInput.availableData, encoding: .utf8)!
    // textInput = textInput.trimmingCharacters(in: .whitespacesAndNewlines)
    
}

