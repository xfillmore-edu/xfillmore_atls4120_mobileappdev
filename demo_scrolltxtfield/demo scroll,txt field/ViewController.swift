//
//  ViewController.swift
//  demo scroll,txt field
//
//  Created by Xuedan Fillmore on 9/24/20.
//
//  NOTE in its current state, app crashes without running
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var checkAmount: UITextField!
    @IBOutlet weak var tipPercent: UITextField!
    @IBOutlet weak var numPeopleLabel: UILabel!
    @IBOutlet weak var numPeopleStep: UIStepper!
    @IBOutlet weak var tipCalcLabel: UILabel!
    @IBOutlet weak var totalCalcLabel: UILabel!
    @IBOutlet weak var perPersonLabel: UILabel!
    
    func calculateTotals() {
        
        // should handle case of if user enters nonnumeric characters
        var amount: Float
        var percentage: Float
        
        if checkAmount.text!.isEmpty {
            amount = 0.0
        }
        else {
            amount = Float(checkAmount.text!)!
        }
        
        if tipPercent.text!.isEmpty {
            percentage = 0.0
        }
        else {
            percentage = Float(tipPercent.text!)! / 100
        }
        
        let numPeople = numPeopleStep.value
        let tip = amount * percentage
        let total = amount + tip
        var personTotal: Float = 0.0
        
        if numPeople > 0 {
            personTotal = total / Float(numPeople)
        }
        else {
            // self refers to current instance of class -- in this case, view controller
            let alert = UIAlertController(title: "Warning", message: "Cannot calculate tip for 0 people", preferredStyle: UIAlertController.Style.alert)
            // create UIAlertAction object for button
            let cancelAction = UIAlertAction(title: "Go back", style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(cancelAction) // adds alert action to alert object
            let okAction = UIAlertAction("title: OK", style: UIAlertAction.Style.cancel, handler: { action in
                self.numPeopleStep.value = 1
                self.numPeopleLabel.text? = "1 person"
                self.calculateTotals()
            })
        }
        
        
        // format results as currency
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = NumberFormatter.Style.currency // set number style
        tipCalcLabel.text = currencyFormatter.string(from: NSNumber(value: tip)) // returns a formatted string
        totalCalcLabel.text = currencyFormatter.string(from: NSNumber(value: total))
            perPersonLabel.text = currencyFormatter.string(from: NSNumber(value:personTotal))
    }
    
    @IBAction func updateNumPeople(_ sender: UIStepper) {
        let newNumP = sender.value
        if (newNumP == 1) {
            numPeopleLabel.text = "1 person"
        }
        else {
            numPeopleLabel.text = String(format: "%.0f", newNumP) + " people"
        }
        calculateTotals()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        calculateTotals()
    }

    override func viewDidLoad() {
        
        checkAmount.delegate = self
        tipPercent.delegate = self
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

