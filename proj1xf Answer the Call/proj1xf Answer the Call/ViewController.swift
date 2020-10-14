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
        Astronaut(name: "Clayton Anderson",   intel: 22, stem: Int.random(in: 1...9), flighttime: 4046),
        Astronaut(name: "Tracy Caldwell",     intel: 22, stem: Int.random(in: 1...9), flighttime: 4529),
        Astronaut(name: "Kalpana Chawla",     intel: 25, stem: Int.random(in: 1...9), flighttime:  758),
        Astronaut(name: "Timothy Creamer",    intel: 22, stem: Int.random(in: 1...9), flighttime: 3912),
        Astronaut(name: "Bonnie Dunbar",      intel: 40, stem: Int.random(in: 1...9), flighttime: 1208),
        Astronaut(name: "Michael Fincke",     intel: 24, stem: Int.random(in: 1...9), flighttime: 9159),
        Astronaut(name: "Michael Foale",      intel: 33, stem: Int.random(in: 1...9), flighttime: 8976),
        Astronaut(name: "Susan Helms",        intel: 30, stem: Int.random(in: 1...9), flighttime: 5064),
        Astronaut(name: "Marsha Ivins",       intel: 36, stem: Int.random(in: 1...9), flighttime: 1318),
        Astronaut(name: "Tamara Jernigan",    intel: 35, stem: Int.random(in: 1...9), flighttime: 1512),
        Astronaut(name: "Timothy Kopra",      intel: 20, stem: Int.random(in: 1...9), flighttime: 1464),
        Astronaut(name: "Richard Linnehan",   intel: 28, stem: Int.random(in: 1...9), flighttime: 1392),
        Astronaut(name: "Shannon Lucid",      intel: 42, stem: Int.random(in: 1...9), flighttime: 5354),
        Astronaut(name: "Donald Pettit",      intel: 24, stem: Int.random(in: 1...9), flighttime: 4224),
        Astronaut(name: "Nicole Stott",       intel: 20, stem: Int.random(in: 1...9), flighttime: 2491),
        Astronaut(name: "Frederick Sturckow", intel: 25, stem: Int.random(in: 1...9), flighttime: 1200),
        Astronaut(name: "Douglas Wheelock",   intel: 22, stem: Int.random(in: 1...9), flighttime: 4272),
        Astronaut(name: "Terrence Wilcutt",   intel: 30, stem: Int.random(in: 1...9), flighttime: 1007),
        Astronaut(name: "Sunita Williams",    intel: 22, stem: Int.random(in: 1...9), flighttime: 4680),
        Astronaut(name: "Stephanie Wilson",   intel: 24, stem: Int.random(in: 1...9), flighttime: 1008)
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
        if (selectedAstronauts.count > 0 && selectedAstronauts[0].intel == 0) {
            selectedAstronauts.removeFirst(1)
        }
        // https://stackoverflow.com/questions/40518705/how-can-i-check-if-a-structure-is-in-the-array-of-structures-based-on-its-field
        if (selectedAstronauts.contains(where: {$0.name == astronauts[indexPath.row].name})) {
            selectedAstronauts.removeAll(where: {$0.name == astronauts[indexPath.row].name} )
        }
        else if (selectedAstronauts.count < 5) {
            selectedAstronauts.append(astronauts[indexPath.row])
        }
        if (selectedAstronauts.count == 0) {
            selectedAstrLabel.text! = "Select up to 5"
        }
        else {
            selectedAstrLabel.text! = ""
        }
        for astr in selectedAstronauts
        {
            selectedAstrLabel.text! += astr.name + " (" + String(astr.flighttime) + " flight hours)\n"
        }
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
    
    // https://developer.apple.com/documentation/swift/range
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
        var failCause : String = "> An unknown malfunction caused the rocket to explode"
        
        dismissKeyboard()
        
        // reset fuel -- also account for if running still
        fuelPump.invalidate()
        fuelPumpBtn.setTitle("Start", for: .normal)
        fuelPumpActive = false
        fuelPumpGaugeLabel.text = "00.00 units"
        
        
        // MD = mission difficulty, SP = success probability
        let launchMD = Int.random(in: 10...75)
        var launchSP = 1
        let travelMD = Int.random(in: 10...75)
        var travelSP = 1
        let moonlandMD = Int.random(in: 10...75)
        var moonlandSP = 1
        let moonlaunchMD = Int.random(in: 10...75)
        var moonlaunchSP = 1
        let returnMD = Int.random(in: 10...75)
        var returnSP = 1
        let landMD = Int.random(in: 10...75)
        var landSP = 1
        
        // evaluate fins for stability
        var numFins = 0
        if (numFinsTxtField.text! != "") {
            numFins = Int(numFinsTxtField.text!)!
        }
        if (numFins == 0)
        {
            travelSP += 3
            returnSP += 3
            failCause = "> The rocket's trajectory could not be controlled and the astronauts were lost to space."
        }
        else {
            if numFins < 3 {
                travelSP = +10
                returnSP = +10
            }
            else if numFins < 5 {
                travelSP = +30
                returnSP = +35
            }
            else if numFins < 99 {
                travelSP = +17
                returnSP = +14
            }
            else {
                failCause = "> The rocket had too many external parts and could not be controlled."
            }
            
        }
        
        // evaluate boost stages, engines, and fuel
        var numEngines = 0
        if (numEnginesTxtField.text! != "") {
            numEngines = Int(numEnginesTxtField.text!)!
        }
        let stages = Int(stagesSegSelector.titleForSegment(at: stagesSegSelector.selectedSegmentIndex)!)!
        if (numEngines == 0 || stages == 0) {
            failCause = "> The rocket cannot launch without an engine or body."
        }
        else {
            if fuelGauge < 200000 {
                failCause = "> The rocket could not produce enough thrust to leave the launchpad."
            }
            else if fuelGauge < 600000 && numEngines > 1 {
                failCause = "> The stage 1 booster had insufficient fuel."
            }
            if (stages > 1) {
                moonlandSP += 35
                moonlaunchSP += 20
                landSP += 40
            }
            if numEngines > 20 {
                if fuelGauge < 2800000 {
                    failCause = "> There was insufficient fuel for all the engines."
                }
                else if stages < 3 {
                    failCause = "> The engines were too heavy."
                }
                else {
                    launchSP += 12
                    moonlaunchSP += 16
                    landSP += 10
                }
            }
            else if numEngines > 13 {
                if fuelGauge < 1700000 {
                    failCause = "> There was insufficient fuel for all the engines."
                }
                else {
                    launchSP += 24
                    moonlaunchSP += 25
                    landSP += 20
                }
            }
            else if numEngines > 9 {
                if fuelGauge < 1100000 {
                    failCause = "> The engines consumed all the fuel too quickly."
                }
                else {
                    launchSP += 24
                    moonlaunchSP += 20
                    landSP += 10
                }
            }
            else if numEngines > 3 {
                if fuelGauge < 500000 {
                    failCause = "> The engines were not supplied with enough fuel."
                }
                else if stages > 2 {
                    failCause = "> Not enough engines were allocated to each stage."
                }
                else {
                    launchSP += 15
                    moonlaunchSP += 10
                    landSP += 4
                }
            }
            else {
                if stages > 1 {
                    failCause = "> Not enough engines were allocated to each stage."
                }
                launchSP += 6
            }
        }
        
        
        // use locLatiSlider and locLongSlider values for geography
        if (verifyLand()) {
            launchSP += 20
        }
        else {
            launchSP = 0
            failCause = "> The launchpad sunk into the ocean."
        }
        
        // apply astronaut multipliers
        var multiplier : Float = 1.0
        var mtotal : Float = 0.0
        var itotal : Float = 0.0
        var totalft : Int = 0
        for astr in selectedAstronauts {
            mtotal += Float(astr.stem) / 10.0
            itotal += Float(astr.intel)
            totalft += astr.flighttime
        }
        mtotal = mtotal / Float(selectedAstronauts.count)
        multiplier += mtotal
        moonlandSP = Int(Float(moonlandSP) * multiplier)
        landSP = Int(Float(landSP) * multiplier)
        
        let bonus = itotal / Float(selectedAstronauts.count)
        if bonus > 37.0 {
            moonlandSP += 10
            moonlaunchSP += 15
            returnSP += 10
            landSP += 5
        }
        else if bonus > 32.0 {
            moonlandSP += 7
            moonlaunchSP += 10
            returnSP += 5
            landSP += 2
        }
        else if bonus > 28.0 {
            moonlandSP += 4
            moonlaunchSP += 5
            returnSP += 2
        }
        else if bonus > 22.0 {
            moonlandSP += 2
            moonlaunchSP += 2
        }
        
        if totalft > 25000 {
            travelSP += 40
            returnSP += 25
            multiplier = 1.85
        }
        else if totalft > 19000 {
            travelSP += 30
            returnSP += 17
            multiplier = 1.7
        }
        else if totalft > 16000 {
            travelSP += 20
            returnSP += 13
            multiplier = 1.5
        }
        else if totalft > 13000 {
            travelSP += 15
            returnSP += 10
            multiplier = 1.33
        }
        else if totalft > 8000 {
            travelSP += 10
            returnSP += 6
            multiplier = 1.17
        }
        else if totalft > 4000 {
            travelSP += 6
            returnSP += 2
            multiplier = 1.08
        }
        else if totalft > 1000 {
            travelSP += 4
            returnSP += 1
            multiplier = 1.04
        }
        launchSP = Int(Float(launchSP) * multiplier)
        travelSP = Int(Float(travelSP) * multiplier)
        moonlaunchSP = Int(Float(moonlaunchSP) * multiplier)
        returnSP = Int(Float(returnSP) * multiplier)
        landSP = Int(Float(landSP) * multiplier)
        
        // enter mission check cycle
        if (launchSP < launchMD) {
            dashboardLabel.text! += failCause
        }
        else {
            // success dashboard message
            dashboardLabel.text! += "> The rocket thundered into the atmosphere and is en route to the moon.\n"
            
            if (travelSP < travelMD) {
                dashboardLabel.text! += failCause
            }
            else {
                // success dashboard message
                dashboardLabel.text! += "> A crackly transmission from the rocket reports that it has reached the moon. \n"
                
                if (moonlandSP < moonlandMD) {
                    dashboardLabel.text! += failCause
                }
                else {
                    // success dashboard message
                    dashboardLabel.text! += "> The lunar module successfully touched down.\n"
                    
                    if (moonlaunchSP < moonlaunchMD) {
                        dashboardLabel.text! += failCause
                    }
                    else {
                        // success dashboard message
                        dashboardLabel.text! += "> The lunar module successfully docked back onto the command module. The rocket is on its way back to earth.\n"
                        
                        if (returnSP < returnMD) {
                            dashboardLabel.text! += failCause
                        }
                        else {
                            // success dashboard message
                            dashboardLabel.text! += "> The rocket is preparing for reentry into Earth's atmosphere.\n"
                            
                            if (landSP < landMD) {
                                dashboardLabel.text! += failCause
                            }
                            else {
                                // final possible success dashboard message
                                dashboardLabel.text! += "> Mission success! The command module and its lunar samples were collected."
                                if selectedAstronauts.count > 0 && selectedAstronauts[0].intel > 0 {
                                    dashboardLabel.text! += " The crew is celebrating in quarantine."
                                }
                                
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
        selectedAstrLabel.text! = "Select up to 5"
        
        // clear flight dashboard
        dashboardLabel.text = "> You have not yet launched."
    }
    
}

