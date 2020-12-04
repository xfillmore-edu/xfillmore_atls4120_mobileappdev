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

    @IBOutlet weak var pImg: UIImageView!
    @IBOutlet weak var pTitle: UILabel!
    @IBOutlet weak var pPoem: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        let contentWidth = scrollSpace.bounds.width
//        let contentHeight = scrollSpace.bounds.height * 3
//        scrollSpace.contentSize = CGSize(width: contentWidth, height: contentHeight)
    }
    
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
            pTitle.text = "Fire and Ice"
            pImg.image = UIImage(named: "fire_and_ice")
            pPoem.text = """
            Some say the world will end in fire, \n
            Some say in ice. \n
            From what I've tasted of desire \n
            I hold with those who favor fire. \n
            But if it had to perish twice, \n
            I think I know enough of hate \n
            To say that for destruction ice \n
            Is also great \n
            And would suffice.
            """
        case 1:
            pTitle.text = "Stopping by Woods on a Snowy Evening"
            pImg.image = UIImage(named: "snowy_woods")
            pPoem.text = """
            Whose woods these are I think I know. \n
            His house is in the village though; \n
            He will not see me stopping here \n
            To watch his woods fill up with snow. \n\n
            """
//            My little horse must think it queer \n
//            To stop without a farmhouse near \n
//            Between the woods and frozen lake \n
//            The darkest evening of the year. \n\n
//            He gives his harness bells a shake \n
//            To ask if there is some mistake. \n
//            The only other sound's the sweep \n
//            Of easy wind and downy flake. \n\n
//            The woods are lovely, dark and deep, \n
//            But I have promises to keep, \n
//            And miles to go before I sleep, \n
//            And miles to go before I sleep.
//            """
        case 2:
            pTitle.text = "Acquainted with the Night"
            pImg.image = UIImage(named: "acquainted_night")
            pPoem.text = """
            I have been one acquainted with the night. \n
            I have walked out of rain -- and back in rain. \n
            I have outwalked the furthest city light.
            """
//            I have looked down the saddest city lane. \n
//            I have passed by the watchman on his beat \n
//            And dropped my eyes, unwilling to explain. \n\n
//            I have stood still and stopped the sound of feet \n
//            When far away an interrupted cry \n
//            Came over houses from another street, \n\n
//            But not to call me back or say good-bye; \n
//            And further still at an unearthly height, \n
//            One luminary clock against the sky \n\n
//            Proclaimed the time was neither wrong nor right. \n
//            I have been one acquainted with the night.
//            """
        case 3:
            pTitle.text = "The Road Not Taken"
            pImg.image = UIImage(named: "road_taken")
            pPoem.text = """
            Two roads diverged in a yellow wood, \n
            And sorry I could not travel both \n
            And be one traveler, long I stood \n
            And looked down one as far as I could \n
            To where it bent in the undergrowth;
            """
//            Then took the other, as just as fair, \n
//            And having perhaps the better claim, \n
//            Because it was grassy and wanted wear; \n
//            Though as for that the passing there \n
//            Had worn them really about the same, \n\n
//            And both that morning equally lay \n
//            In leaves no step had trodden black. \n
//            Oh, I kept the first for another day! \n
//            Yet knowing how way leads on to way, \n
//            I doubted if I should ever come back. \n\n
//            I shall be telling this with a sigh \n
//            Somewhere ages and ages hence: \n
//            Two roads diverged in a wood, and I-- \n
//            I took the one less traveled by, \n
//            And that has made all the difference.
//            """
        default:
            pTitle.text = "Fire and Ice"
            pImg.image = UIImage(named: "fire_and_ice")
            pPoem.text = """
            Some say the world will end in fire, \n
            Some say in ice. \n
            From what I've tasted of desire \n
            I hold with those who favor fire. \n
            But if it had to perish twice, \n
            I think I know enough of hate \n
            To say that for destruction ice \n
            Is also great \n
            And would suffice.
            """
            
        }
    }
    
}
// this is a test line
// use Win in place of ctrl!!
