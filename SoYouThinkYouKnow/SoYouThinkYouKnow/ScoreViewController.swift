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

    @IBOutlet weak var yourScoreLabel: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var moveToNextRound: UIButton!
    

    var currentScore = Int()
    var currentRound = Int()
    var overallGameScore = Int()

    var roundOne = Scoring.sharedGameData.tfscore
    var roundTwo = (Scoring.sharedGameData.tfscore + Scoring.sharedGameData.mcscore)
    var roundThree = (Scoring.sharedGameData.tfscore + Scoring.sharedGameData.mcscore + Scoring.sharedGameData.photoscore)
    var roundFour = (Scoring.sharedGameData.tfscore + Scoring.sharedGameData.mcscore + Scoring.sharedGameData.photoscore + Scoring.sharedGameData.mapsscore)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let  HighscoreDefault = NSUserDefaults.standardUserDefaults()
        //let TFScore = NSUserDefaults.standardUserDefaults()
        //let MCScore = NSUserDefaults.standardUserDefaults()
        //let PhotosScore = NSUserDefaults.standardUserDefaults()
        //let MapsScore = NSUserDefaults.standardUserDefaults()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ScoreViewController.endOfFirstRound(_:)), name: "endOfRoundOne", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ScoreViewController.endofSecondRound(_:)), name: "endOfRoundTwo", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ScoreViewController.endofThirdRound(_:)), name: "endOfRoundThree", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ScoreViewController.endOfFourthRound(_:)), name: "endOfRoundFour", object: nil)
        
        UIView.animateWithDuration(2.0, delay: 1.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7,
                                   options: UIViewAnimationOptions.AllowAnimatedContent, animations: ({
        self.yourScoreLabel.center.x = 32
        self.yourScoreLabel.center.y = 200
        self.yourScoreLabel.alpha = 1.0
        }), completion: nil)
        
        
    }
    
    
    func endOfFirstRound (notification: NSNotification) {
       
        scoreLabel.text = "Score: \(roundOne)"
        
        if case 0 ... 4 = roundOne {
            levelLabel.text = "Never Been Heah"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "never1.png")!)
        }
        if case 5 ... 8 = roundOne {
            levelLabel.text = "One Timah"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "onetimah.png")!)
        }
        if case 9 ... 11 = roundOne {
            levelLabel.text = "Weekend Warrior"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "weekendwarrior.png")!)
        }
        if case 12 ... 15 = roundOne {
            levelLabel.text = "Transplant"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "Transplant.png")!)
        }
        if case 16 ... 20 = roundOne{
            levelLabel.text = "Mainah"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "mainah.png")!)
        }
        if case 21 ... 50 = roundOne {
            levelLabel.text = "TRUE BLUE MAINAH"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "trueblue1.png")!)
        }
        
        currentRound = 1
        
    }
    
    func endofSecondRound (notification: NSNotification) {
       
        
        scoreLabel.text = "Score: \(roundTwo)"
        
        if case 0 ... 4 = roundTwo {
            levelLabel.text = "Never Been Heah"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "never1.png")!)
        }
        if case 5 ... 9 = roundTwo {
            levelLabel.text = "One Timah"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "onetimah.png")!)
        }
        if case 10 ... 17 = roundTwo {
            levelLabel.text = "Weekend Warrior"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "weekendwarrior.png")!)
        }
        if case 18 ... 25 = roundTwo {
            levelLabel.text = "Transplant"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "Transplant.png")!)
        }
        if case 26 ... 33 = roundTwo{
            levelLabel.text = "Mainah"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "mainah.png")!)
        }
        if case 34 ... 40 = roundTwo {
            levelLabel.text = "TRUE BLUE MAINAH"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "trueblue1.png")!)
        }
        currentRound = 2
    }
    
    func endofThirdRound (notification: NSNotification) {
        
        
        
        scoreLabel.text = "Score: \(roundThree)"
        
        
        if case 0 ... 30 = roundThree {
            levelLabel.text = "Never Been Heah"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "never1.png")!)
        }
        if case 31 ... 45 = roundThree {
            levelLabel.text = "One Timah"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "onetimah.png")!)
        }
        if case 46 ... 100 = roundThree {
            levelLabel.text = "Weekend Warrior"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "weekendwarrior.png")!)
        }
        if case 101 ... 200 = roundThree {
            levelLabel.text = "Transplant"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "Transplant.png")!)
        }
        if case 201 ... 400 = roundThree{
            levelLabel.text = "Mainah"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "mainah.png")!)
        }
        if case 401 ... 1500 = roundThree {
            levelLabel.text = "TRUE BLUE MAINAH"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "trueblue1.png")!)
        }
        currentRound = 3
    }
    
    func endOfFourthRound (notification: NSNotification) {
        
       
        
        scoreLabel.text = "Score: \(roundFour)"
        
        if case 0 ... 150 = roundFour {
            levelLabel.text = "Never Been Heah"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "never1.png")!)
        }
        if case 150 ... 299 = roundFour {
            levelLabel.text = "One Timah"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "onetimah.png")!)
        }
        if case 300 ... 499 = roundFour {
            levelLabel.text = "Weekend Warrior"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "weekendwarrior.png")!)
        }
        if case 500 ... 649 = roundFour {
            levelLabel.text = "Transplant"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "Transplant.png")!)
        }
        if case 650 ... 799 = roundFour{
            levelLabel.text = "Mainah"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "mainah.png")!)
        }
        if case 800 ... 1000 = roundFour {
            levelLabel.text = "TRUE BLUE MAINAH"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "trueblue1.png")!)
        }
        currentRound = 4
        
        Scoring.sharedGameData.overallscore = roundFour
    }
    
    
    
    
    @IBAction func nextRound(sender: AnyObject) {
        if currentRound == 1 {
            //go to Mult Choice vc
            
            
        } else if currentRound == 2 {
            //go to Photos vc
            
        } else if currentRound == 3 {
            //go to Maps vc
            
        } else if currentRound == 4 {
            
            //game over go to final vc
        }
    }
    
    
    
}
