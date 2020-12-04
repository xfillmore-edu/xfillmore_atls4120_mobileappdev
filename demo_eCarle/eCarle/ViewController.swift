//
//  ViewController.swift
//  eCarle
//
//  Created by Xuedan Fillmore on 9/1/20.
//  Copyright © 2020 0xFillmore. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var animal: UIImageView!
    
    @IBAction func chooseAnimal(_ sender: UIButton) {
        if sender.tag == 1 {
            animal.image = UIImage(named: "brownBear")
        }
        else if sender.tag == 2 {
            animal.image = UIImage(named: "ladybug")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

