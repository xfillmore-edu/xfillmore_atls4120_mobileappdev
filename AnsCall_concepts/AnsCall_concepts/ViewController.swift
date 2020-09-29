//
//  ViewController.swift
//  AnsCall_concepts
//
//  Created by Xuedan Fillmore on 9/28/20.
//  Copyright © 2020 Xuedan Fillmore. All rights reserved.
//
// Timed fuel system designed based on:
// https://www.youtube.com/watch?v=z2Jq5U-stag&vl=en
// https://stackoverflow.com/questions/26641571/how-to-change-button-text-in-swift-xcode-6
//
// Random number generation
// https://www.hackingwithswift.com/articles/102/how-to-generate-random-numbers-in-swift
//
//
// Table View -> Editable list
// https://docs.swift.org/swift-book/LanguageGuide/ClassesAndStructures.html



import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // timer/fuel proof of concept (variables)
    var fuelGauge: Float = 0.00
    var fuelPump = Timer()
    var startstopState = false // stopped state
    @IBOutlet weak var gaugeLabel: UILabel! // will need to set constraint for min width to prevent cutoff of "units"
    @IBOutlet weak var fuelbtn: UIButton!
    
    @IBAction func fuelButton(_ sender: UIButton) {
        if (startstopState == false) {
            // button says Start
            startstopState = true
            fuelbtn.setTitle("Stop", for: .normal)
            fuelPump = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(FuelPump), userInfo: nil, repeats: true)
        }
        else {
            // button says Stop
            startstopState = false
            fuelbtn.setTitle("Start", for: .normal)
            fuelPump.invalidate()
        }
    } // fuelButton fn
    @objc func FuelPump() {
        fuelGauge += 0.08
        gaugeLabel.text = String(format: "%.2f", fuelGauge) + " units"
    }
    
    // Random number generation (RNG)
    @IBOutlet weak var difficultyLbl: UILabel!
    var missionDifficulty : Int! = 100
    @IBOutlet weak var messageLabel: UILabel!
    func calculateSuccess() {
        difficultyLbl.text = String(missionDifficulty)
        if (missionDifficulty < 40){
            messageLabel.text = "success"
        }
        else {
            messageLabel.text = "failure"
        }
    }
    @IBAction func missionTrigger(_ sender: Any) {
        missionDifficulty = Int.random(in: 10...100)
        calculateSuccess()
    }
    
    struct Astronaut {
        var name:String
        var technicalBonus:Int
        var blackoutSpeed:Int
        
        
    }
    
    
    
    
    
    
    @IBAction func resetBTN(_ sender: UIButton) {
        fuelGauge = 0.0
        gaugeLabel.text = "0.00 units"
        fuelPump.invalidate()
        fuelbtn.setTitle("Start", for: .normal)
        
        missionDifficulty = 100
    }
}

