//
//  ScoreViewController.swift
//  SoYouThinkYouKnow
//
//  Created by Eric Chamberlin on 3/9/16.
//  Copyright © 2016 Eric Chamberlin. All rights reserved.
//

import UIKit
import GameKit

class ScoreViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    
    @IBOutlet weak var mult: UIButton!
    @IBOutlet weak var maps: UIButton!
    @IBOutlet weak var photo: UIButton!
    //var currentscore:String
    var currentScore = Int()
    //var currrentScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let  HighscoreDefault = NSUserDefaults.standardUserDefaults()
        let TFScore = NSUserDefaults.standardUserDefaults()
        let MCScore = NSUserDefaults.standardUserDefaults()
        let PhotosScore = NSUserDefaults.standardUserDefaults()
        let MapsScore = NSUserDefaults.standardUserDefaults()
        
        print(TFScore.valueForKey("tfscore"))
        
        //MCScore.valueForKey("mcscore")
       
        
        currentScore = TFScore.valueForKey("tfscore") as! NSInteger
        
        
        //currentScore = HighscoreDefault.valueForKey("highscore") as! NSInteger
        
        scoreLabel.text = NSString(format: "Score: %i", currentScore) as String
    }
    
    
    
    
}
