//
//  ViewController.swift
//  project2_guest_the_flag
//
//  Created by Wendy Sanarwanto on 1/6/16.
//  Copyright © 2016 Wendy Sanarwanto. All rights reserved.
//

import GameplayKit
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var countries = [String]()
    var correct_answer = 0
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Initialise countries array
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        // Set button's border width
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        // Set button's border color
        button1.layer.borderColor = UIColor.lightGrayColor().CGColor
        button2.layer.borderColor = UIColor.lightGrayColor().CGColor
        button3.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        askQuestion(nil)
    }

    @IBAction func buttonTapped(sender: UIButton) {
        let clicked_tag = sender.tag
        
        // Check whether the answer is correct or not
        if (clicked_tag == correct_answer){
            // Adjust the player's score up
            title = "Correct"
            ++score
        }
        else{
            // or down
            title = "Wrong"
            --score
        }
        
        // Show a message telling them what their new score is
        let message = "Your score is \(score)."
        let alert_ctl = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert_ctl.addAction(UIAlertAction(title: "Continue?", style: .Default, handler: askQuestion))
        presentViewController(alert_ctl, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    func askQuestion(alertAction: UIAlertAction!){
        // Suffle countries array by using GameKit play's RandomSource
        countries = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(countries) as! [String]
        
        // Set the button's image by using the image that is loaded from assets
        button1.setImage(UIImage(named: countries[0]), forState: .Normal)
        button2.setImage(UIImage(named: countries[1]), forState: .Normal)
        button3.setImage(UIImage(named: countries[2]), forState: .Normal)
        
        // setup correct answer
        correct_answer = GKRandomSource.sharedRandom().nextIntWithUpperBound(3)
        
        // Put the county's name as the view's title
        title = countries[correct_answer].uppercaseString
    }
    
}