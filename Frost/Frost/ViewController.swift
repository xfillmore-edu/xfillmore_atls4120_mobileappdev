//
//  ViewController.swift
//  Frost
//
//  Created by Xuedan Fillmore on 9/9/20.
//  Copyright © 2020 0xFillmore. All rights reserved.
//

import UIKit
var cPoem : Int8 = 0

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var pImg: UIImageView!
    @IBOutlet weak var pTitle: UILabel!
    @IBOutlet weak var pPoem: UIStackView!
    
    @IBAction func nxtButton(_ sender: UIButton) {
        // set poem selector to next poem, or back to beginning
        cPoem = cPoem + 1
        if cPoem == 4 {
            cPoem = 0
        }
        setNewPage()
    }
    @IBAction func prevButton(_ sender: UIButton) {
        // set poem selector to previous poem, or to end
        cPoem = cPoem - 1
        if cPoem == -1 {
            cPoem = 3
        }
        setNewPage()
    }
    
    func setNewPage() {
        switch(cPoem)
        {
        case 0:
            pImg.image = UIImage(named: "fire_and_ice")
        case 1:
            pImg.image = UIImage(named: "snowy_woods")
        case 2:
            pImg.image = UIImage(named: "acquainted_night")
        case 3:
            pImg.image = UIImage(named: "road_taken")
        default:
            pImg.image = UIImage(named: "fire_and_ice")
        }
    }
    
}

