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
// https://developer.apple.com/documentation/uikit/views_and_controls/table_views
//    will require delegate (UITableViewDelegate)/protocol (UITableViewDataSource) setup
//    recommend using UITableViewController
//    perform actions on rows using UISwipeActionsConfiguration and UIContextualAction?



import UIKit

//struct Astronaut {
//    var name:String
//    var skill:Int
//    init(_ name_:String,_ skill_:Int) {
//        self.name = name_
//        self.skill = skill_
//    }
//}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

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
    
    
    // Table View proof of concept
    // assign tableViewName.delegate = self and tableViewName.dataSource = self in viewDidLoad()
    // add UITableViewDelegate and UITableViewDataSource to ViewController class
    struct Astronaut {
        var name :String
        var skill :Int
        init(name: String, skill: Int) {
            self.name = name
            self.skill = skill
        }
    }
    var astr1 = Astronaut(name: "qwerty", skill: 5)
    var astr2 = Astronaut(name: "asdf", skill: 3)
    var astr3 = Astronaut(name: "artemis", skill: 9)
    var astr4 = Astronaut(name: "curiosity", skill: 8)
    var astr5 = Astronaut(name: "isaac asimov", skill: 10)
//    var astronauts = [astr1, astr2, astr3, astr4, astr5] // https://developer.apple.com/forums/thread/118026
//    var astronauts:[Astronaut] = [] // https://developer.apple.com/forums/thread/98132
//    astronauts[0] = astr1 // consecutive declarations error
//    astronauts.append(astr1) // consecutive declarations error but https://stackoverflow.com/questions/26821347/how-do-you-load-structs-into-an-array
//    astronauts.insert(astr1, at: 0) // consecutive declarations error

    // array method for removing elements is .remove(at: index)
    
    // https://www.youtube.com/watch?v=FRQ9-HKkSow
    @IBOutlet weak var namesTableView: UITableView!
    // can use arrayName.count
    var numSelectedAstronauts : Int = 5 // will be initialized to 0 and be capped at 5
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numSelectedAstronauts;
    }
    var astronauts = ["one", "two", "three", "four", "five"] // because struct isn't working
    
    // creates cell objects
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // withIdentifier comes from the identifier specified under the attributes inspector for the prototype cell -> create table, set prototype cells to 1, select prototype cell, modify its identifier
        let cell = namesTableView.dequeueReusableCell(withIdentifier: "astronautCell", for: indexPath)
        cell.textLabel?.text = astronauts[indexPath.row]//.name
        return cell
    }
    
    
    
    @IBAction func resetBTN(_ sender: UIButton) {
        fuelGauge = 0.0
        gaugeLabel.text = "0.00 units"
        fuelPump.invalidate()
        fuelbtn.setTitle("Start", for: .normal)
        
        missionDifficulty = 100
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        namesTableView.delegate = self
        namesTableView.dataSource = self
    }
}

