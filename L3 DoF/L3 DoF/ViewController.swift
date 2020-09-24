//
//  ViewController.swift
//  L3 DoF
//
//  Created by Xuedan Fillmore on 9/23/20.
//

import UIKit
import CoreGraphics.CGBase

class ViewController: UIViewController {
    
    // linked outlet variables
    @IBOutlet weak var aperture: UISegmentedControl!
    @IBOutlet weak var dofimg: UIImageView!
    @IBOutlet weak var textSize: UISlider!
    @IBOutlet weak var capState: UISwitch!
    @IBOutlet weak var dofDef: UILabel!
    @IBOutlet weak var numTextSize: UILabel!
    @IBOutlet weak var viewTitle: UILabel!
    @IBOutlet weak var cval_red: UILabel!
    @IBOutlet weak var cval_green: UILabel!
    @IBOutlet weak var cval_blue: UILabel!
    var numericRed: CGFloat = 0
    var numericGreen: CGFloat = 0
    var numericBlue: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textSize.value = 17
    }
    
    func formatAll() {
        // format image based on segmented selector
        if (aperture.selectedSegmentIndex == 0) {
            dofimg.image = UIImage(named: "aperture_f4-8")
            dofDef.text = "At an f-stop of 4.8 (the largest aperture here), only the closest object is in focus because that is where the camera's focus is aimed and the depth of field is thin."
        }
        else if (aperture.selectedSegmentIndex == 1) {
            dofimg.image = UIImage(named: "aperture_f8")
            dofDef.text = "At an f-stop of 8, the second object increases in clarity but is still blurry. The increased depth of field means the first object still stays in focus."
        }
        else if (aperture.selectedSegmentIndex == 2) {
            dofimg.image = UIImage(named: "aperture_f32")
            dofDef.text = "At an f-stop of 32, all objects are clear because the depth of field is very large. The aperture is very small."
        }
        
        // format text capitalization based on switch
        if (capState.isOn) {
            viewTitle.text = viewTitle.text?.uppercased()
        }
        else {
            viewTitle.text = viewTitle.text?.lowercased()
        }
        
        // format text size based on slider
        numTextSize.text = String(format: "%.0f", textSize.value)
        let tscgf = CGFloat(textSize.value)
        dofDef.font = UIFont.systemFont(ofSize: tscgf)
        
        // set text color based on stepper values for R,G,B
        let tbodyColor = UIColor(red: numericRed, green: numericGreen, blue: numericBlue, alpha: 1)
        dofDef.textColor = tbodyColor
        cval_red.text = String(format: "%.0f", numericRed * 255.0)
        cval_green.text = String(format: "%.0f", numericGreen * 255.0)
        cval_blue.text = String(format: "%.0f", numericBlue * 255.0)
        
    }
    
    @IBAction func selectAperture(_ sender: UISegmentedControl) {
        formatAll()
        
//        if (sender.selectedSegmentIndex == 0) {
//            dofimg.image = UIImage(named: "aperture_f4-8")
//        }
//        else if (sender.selectedSegmentIndex == 1) {
//            dofimg.image = UIImage(named: "aperture_f8")
//        }
//        else if (sender.selectedSegmentIndex == 2) {
//            dofimg.image = UIImage(named: "aperture_f32")
//        }
    }
    
    @IBAction func slideTextSize(_ sender: UISlider) {
        formatAll()
        
//        let fSize = sender.value // float
//        numTextSize.text = String(format:"%.0f", fSize) // change displayed number for size
//        let fSizeCGF = CGFloat(fSize) // convert numeric value
//        dofDef.font = UIFont.systemFont(ofSize: fSizeCGF) // update font size for description
    }
    
    @IBAction func switchCapState(_ sender: UISwitch) {
        formatAll()
        
//        if (sender.isOn) {
//            viewTitle.text = viewTitle.text?.uppercased()
//        }
//        else {
//            viewTitle.text = viewTitle.text?.lowercased()
//        }
    }
    
    @IBAction func stepRed(_ sender: UIStepper) {
        numericRed = CGFloat(sender.value / 255.0)
        formatAll()
    }
    @IBAction func stepGreen(_ sender: UIStepper) {
        numericGreen = CGFloat(sender.value / 255.0)
        formatAll()
    }
    @IBAction func stepBlue(_ sender: UIStepper) {
        numericBlue = CGFloat(sender.value / 255.0)
        formatAll()
    }
}

