//
//  ViewController.swift
//  proj1xf Answer the Call
//
//  Created by Xuedan Fillmore on 10/11/20.
//  Copyright © 2020 Xuedan Fillmore. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // interface builder outlets
    @IBOutlet weak var stagesSegSelector: UISegmentedControl!
    @IBOutlet weak var numEnginesTxtField: UITextField!
    @IBOutlet weak var numFinsTxtField: UITextField!
    @IBOutlet weak var fuelPumpGaugeLabel: UILabel!
    @IBOutlet weak var fuelPumpBtn: UIButton!
    @IBOutlet weak var locLatiSlider: UISlider!
    @IBOutlet weak var locLongSlider: UISlider!
    @IBOutlet weak var astronautsTableView: UITableView!
    @IBOutlet weak var selectedAstrLabel: UILabel!
    @IBOutlet weak var dashboardLabel: UILabel!
    
    // fuel timer variables
    var fuelGauge : Float = 0.00
    var fuelPump = Timer()
    var fuelPumpActive = false
    
    // astronauts table view variables
    // added Hashable due to error with astronauts set
    // https://stackoverflow.com/questions/26821347/how-do-you-load-structs-into-an-array
    // https://developer.apple.com/forums/thread/118026
    // https://developer.apple.com/forums/thread/98132
    // https://docs.swift.org/swift-book/LanguageGuide/ClassesAndStructures.html
    
    struct Astronaut : Hashable{
        var name :String
        var intel :Int
        var stem :Int
        var flighttime :Int
        init(name n: String, intel sk: Int, stem exp: Int, flighttime ft: Int) {
            self.name = n
            self.intel = sk
            self.stem = exp
            self.flighttime = ft
        }
        init() {
            self.name = ""
            self.intel = 0
            self.stem = 0
            self.flighttime = 0
        }
    }
    // data based on https://www.theguardian.com/news/datablog/2011/jul/08/us-astronauts-listed-nasa
    let astronauts: [Astronaut] = [
        Astronaut(name: "Clayton Anderson",   intel: 22, stem: Int.random(in: 1...10), flighttime: 4046),
        Astronaut(name: "Tracy Caldwell",     intel: 22, stem: Int.random(in: 1...10), flighttime: 4529),
        Astronaut(name: "Kalpana Chawla",     intel: 25, stem: Int.random(in: 1...10), flighttime:  758),
        Astronaut(name: "Timothy Creamer",    intel: 22, stem: Int.random(in: 1...10), flighttime: 3912),
        Astronaut(name: "Bonnie Dunbar",      intel: 40, stem: Int.random(in: 1...10), flighttime: 1208),
        Astronaut(name: "Michael Fincke",     intel: 24, stem: Int.random(in: 1...10), flighttime: 9159),
        Astronaut(name: "Michael Foale",      intel: 33, stem: Int.random(in: 1...10), flighttime: 8976),
        Astronaut(name: "Susan Helms",        intel: 30, stem: Int.random(in: 1...10), flighttime: 5064),
        Astronaut(name: "Marsha Ivins",       intel: 36, stem: Int.random(in: 1...10), flighttime: 1318),
        Astronaut(name: "Tamara Jernigan",    intel: 35, stem: Int.random(in: 1...10), flighttime: 1512),
        Astronaut(name: "Timothy Kopra",      intel: 20, stem: Int.random(in: 1...10), flighttime: 1464),
        Astronaut(name: "Richard Linnehan",   intel: 28, stem: Int.random(in: 1...10), flighttime: 1392),
        Astronaut(name: "Shannon Lucid",      intel: 42, stem: Int.random(in: 1...10), flighttime: 5354),
        Astronaut(name: "Donald Pettit",      intel: 24, stem: Int.random(in: 1...10), flighttime: 4224),
        Astronaut(name: "Nicole Stott",       intel: 20, stem: Int.random(in: 1...10), flighttime: 2491),
        Astronaut(name: "Frederick Sturckow", intel: 25, stem: Int.random(in: 1...10), flighttime: 1200),
        Astronaut(name: "Douglas Wheelock",   intel: 22, stem: Int.random(in: 1...10), flighttime: 4272),
        Astronaut(name: "Terrence Wilcutt",   intel: 30, stem: Int.random(in: 1...10), flighttime: 1007),
        Astronaut(name: "Sunita Williams",    intel: 22, stem: Int.random(in: 1...10), flighttime: 4680),
        Astronaut(name: "Stephanie Wilson",   intel: 24, stem: Int.random(in: 1...10), flighttime: 1008)
    ]
    var selectedAstronauts : [Astronaut] = [Astronaut(name: "Select up to 5", intel: 0, stem: 0, flighttime: 0)] // declare and initialize selectedAstronauts array
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locLatiSlider.value = 0
        locLongSlider.value = 0
        
        astronautsTableView.delegate = self
        astronautsTableView.dataSource = self
        
        // scroll view external resource(s)
        // https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/WorkingwithScrollViews.html
        
    }
    
    // ///////////////////////////////////////////////////// //
    // /////////////////// action functions //////////////// //
    // ///////////////////////////////////////////////////// //
    
    //
    // rocket boost stages segmented control
    // no associated function
    // value read when blast off button selected (below)
    //
    
    //
    // text field controls for number of engines and fins
    //
    func dismissKeyboard() {
        // https://www.hackingwithswift.com/forums/swiftui/textfield-dismiss-keyboard-clear-button/240
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        textField.resignFirstResponder()
        return true
    }
    // linked to background button
    @IBAction func hideKeyboard(_ sender: Any) {
        dismissKeyboard()
    }
    
    //
    // fuel pump timer
    // https://www.youtube.com/watch?v=z2Jq5U-stag&vl=en
    // https://www.hackingwithswift.com/articles/117/the-ultimate-guide-to-timer
    //
    @objc func PumpFuel() {
        fuelGauge += 89.76
        fuelPumpGaugeLabel.text = String(format: "%.2f", fuelGauge)
        
    }
    @IBAction func pumpFuel(_ sender: Any) {
        dismissKeyboard()
        if (fuelPumpActive == false) {
            // button says Start
            fuelPumpActive = true
            fuelPumpBtn.setTitle("Stop", for: .normal)
            fuelPump = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(PumpFuel), userInfo: nil, repeats: true)
        }
        else {
            // button says Stop
            fuelPumpActive = false
            fuelPumpBtn.setTitle("Start", for: .normal)
            fuelPump.invalidate()
        }
    }

    
    //
    // Astronauts table view manipulation
    // https://developer.apple.com/documentation/uikit/views_and_controls/table_views
    // individual cell colors https://stackoverflow.com/a/38846099
    // UITableViewDelegate https://developer.apple.com/documentation/uikit/uitableviewdelegate
    // https://www.youtube.com/watch?v=FRQ9-HKkSow
    //
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (selectedAstronauts[0].intel == 0) {
            selectedAstronauts.removeFirst(1)
        }
        selectedAstronauts.append(astronauts[indexPath.row])
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return astronauts.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = astronautsTableView.dequeueReusableCell(withIdentifier: "astronautCell", for: indexPath)
        cell.textLabel?.text = astronauts[indexPath.row].name
        return cell
    }

    //
    // blast off button actions
    //
    
    // https://www.hackingwithswift.com/articles/90/how-to-check-whether-a-value-is-inside-a-range
    func verifyLand() -> Bool {
        var isLand = false
        
        let rlat1 = 25 ... 55 // mid N. Amer
        let rlon1 = -125 ... -72
        let rlat2 = 30 ... 70 // upper Asia
        let rlon2 = 49 ... 138
        let rlat3 = 57 ... 69 // upper N. Amer
        let rlon3 = -158 ... -94
        let rlat4 = 5 ... 30 // upper Africa
        let rlon4 = -13 ... 51
        let rlat5 = 37 ... 67 // Europe
        let rlon5 = -6 ... 60
        let rlat6 = -30 ... 4 // lower Africa
        let rlon6 = 11 ... 43
        let rlat7 = 65 ... 81 // artic (greenland)
        let rlon7 = -60 ... -16
        let rlat8 = -24 ... 2 // upper S. Amer
        let rlon8 = -79 ... -38
        let rlat9 = -54 ... -30  // lower S. Amer
        let rlon9 = -75 ... -57
        let rlat10 = 12 ... 21  // central Amer
        let rlon10 = -106 ... -84
        let rlat11 = 13 ... 36 // lower Asia
        let rlon11 = 62 ... 120
        let rlat12 = -35 ... -15 // Australia
        let rlon12 = 115 ... 150
        let rlat13 = -90 ... -72 // Antarctica
        let rlon13 = -180 ... 180
        
        
        let lat = Int(locLatiSlider.value)
        let lon = Int(locLongSlider.value)
        
        if (
            (rlat1.contains(lat) && rlon1.contains(lon)) ||
            (rlat2.contains(lat) && rlon2.contains(lon)) ||
            (rlat3.contains(lat) && rlon3.contains(lon)) ||
            (rlat4.contains(lat) && rlon4.contains(lon)) ||
            (rlat5.contains(lat) && rlon5.contains(lon)) ||
            (rlat6.contains(lat) && rlon6.contains(lon)) ||
            (rlat7.contains(lat) && rlon7.contains(lon)) ||
            (rlat8.contains(lat) && rlon8.contains(lon)) ||
            (rlat9.contains(lat) && rlon9.contains(lon)) ||
            (rlat10.contains(lat) && rlon10.contains(lon)) ||
            (rlat11.contains(lat) && rlon11.contains(lon)) ||
            (rlat12.contains(lat) && rlon12.contains(lon)) ||
            (rlat13.contains(lat) && rlon13.contains(lon))
            ) { isLand = true }
        return isLand
    }
    
    @IBAction func blastOffBtn(_ sender: UIButton) {
        // clear flight dashboard
        dashboardLabel.text = "> Preparing for launch...\n"
        var failCause : String?
        
        dismissKeyboard()
        
        // reset fuel -- also account for if running still
        fuelPump.invalidate()
        fuelPumpBtn.setTitle("Start", for: .normal)
        fuelPumpActive = false
        fuelPumpGaugeLabel.text = "00.00 units"
        
        
        // MD = mission difficulty, SP = success probability
        let launchMD = Int.random(in: 10...95)
        var launchSP = 0
        let travelMD = Int.random(in: 10...95)
        var travelSP = 0
        let moonlandMD = Int.random(in: 10...95)
        var moonlandSP = 0
        let moonlaunchMD = Int.random(in: 10...95)
        var moonlaunchSP = 0
        let returnMD = Int.random(in: 10...95)
        var returnSP = 0
        let landMD = Int.random(in: 10...95)
        var landSP = 0
        
        // use locLatiSlider and locLongSlider values for geography
        if (verifyLand()) {
            launchSP = 30
        }
        else {
            failCause = "> The launchpad sunk into the ocean."
        }
        
        // evaluate boost stages, engines, and fuel
        
        
        if (launchSP < launchMD) {
            dashboardLabel.text! += failCause!
        }
        else {
            // success dashboard message
            
            if (travelSP < travelMD) {
                dashboardLabel.text! += failCause!
            }
            else {
                // success dashboard message
                
                if (moonlandSP < moonlandMD) {
                    dashboardLabel.text! += failCause!
                }
                else {
                    // success dashboard message
                    
                    if (moonlaunchSP < moonlaunchMD) {
                        dashboardLabel.text! += failCause!
                    }
                    else {
                        // success dashboard message
                        
                        if (returnSP < returnMD) {
                            dashboardLabel.text! += failCause!
                        }
                        else {
                            // success dashboard message
                            
                            if (landSP < landMD) {
                                dashboardLabel.text! += failCause!
                            }
                            else {
                                // final possible success dashboard message
                                
                            } // land
                        } // return
                    } // moonlaunch
                } // moonland
            } // travel
        } // launch
        
        fuelGauge = 0.00
        
        
    } // end blast off button action function
    
    //
    // reset all to default state
    // 
    @IBAction func resetAll(_ sender: UIButton) {
        // deselect boost stages
       //  https://developer.apple.com/documentation/uikit/uisegmentedcontrol/1618575-selectedsegmentindex?language=objc
        stagesSegSelector.selectedSegmentIndex = -1
        
        // clear text fields
        numEnginesTxtField.text! = ""
        numFinsTxtField.text! = ""
        dismissKeyboard()
        
        // reset fuel timer
        fuelPump.invalidate()
        fuelPumpActive = false
        fuelPumpBtn.setTitle("Start", for: .normal)
        fuelGauge = 0.00
        fuelPumpGaugeLabel.text = "00.00 units"
        
        // set latitude and longitude to 0, 0
        locLongSlider.value = 0
        locLatiSlider.value = 0
        
        // clear astronauts
        selectedAstronauts.removeAll()
        selectedAstronauts.append(Astronaut(name:"Select up to 5", intel: 0, stem: 0, flighttime: 0))
        
        // clear flight dashboard
        dashboardLabel.text = "> You have not yet launched."
    }
    
}

