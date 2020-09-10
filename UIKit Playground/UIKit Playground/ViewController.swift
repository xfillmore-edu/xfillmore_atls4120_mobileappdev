//
//  ViewController.swift
//  UIKit Playground
//
//  Created by Xuedan Fillmore on 9/10/20.
//  Copyright © 2020 0xFillmore. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var coverImg: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var fontSize: UILabel!
    @IBOutlet weak var capSwitch: UISwitch!
    @IBOutlet weak var fsSlide: UISlider!
    
    @IBAction func albumSwitch(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            coverImg.image = UIImage(named:"nightvis")
            titleText.text = "Their first album"
        }
        else if sender.selectedSegmentIndex == 1 {
            coverImg.image = UIImage(named:"origins")
            titleText.text = "Their most recent album"
        }
    }
    @IBAction func toggleCaps(_ sender: UISwitch) {
        if sender.isOn {
            // capitalize
            titleText.text = titleText.text?.uppercased()
        }
        else
        {
            // lower case
            titleText.text = titleText.text?.lowercased()
        }
    }
    @IBAction func changeFontSize(_ sender: UISlider) {
        // get new value
        let fSize = sender.value // float type
        // update fontSize label
        fontSize.text = String(format: "%.0f", fSize)
        // update titleText font size
        let fSizeCGf = CGFloat(fSize)
        titleText.font = UIFont.systemFont(ofSize: fSizeCGf)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

