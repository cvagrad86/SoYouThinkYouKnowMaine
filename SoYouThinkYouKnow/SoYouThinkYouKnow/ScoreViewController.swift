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
    var overallGameScore = (
        Scoring.sharedGameData.tfscore +
        Scoring.sharedGameData.mcscore +
        Scoring.sharedGameData.photoscore +
        Scoring.sharedGameData.mapsscore)

    var roundOne = Scoring.sharedGameData.tfscore
    var roundTwo = (Scoring.sharedGameData.tfscore + Scoring.sharedGameData.mcscore)
    var roundThree = (Scoring.sharedGameData.tfscore + Scoring.sharedGameData.mcscore + Scoring.sharedGameData.photoscore)
    var roundFour = (Scoring.sharedGameData.tfscore + Scoring.sharedGameData.mcscore + Scoring.sharedGameData.photoscore + Scoring.sharedGameData.mapsscore)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let  HighscoreDefault = NSUserDefaults.standardUserDefaults()
        let TFScore = NSUserDefaults.standardUserDefaults()
        let MCScore = NSUserDefaults.standardUserDefaults()
        let PhotosScore = NSUserDefaults.standardUserDefaults()
        let MapsScore = NSUserDefaults.standardUserDefaults()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ScoreViewController.endOfFirstRound(_:)), name: "endOfRoundOne", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ScoreViewController.endofSecondRound(_:)), name: "endOfRoundTwo", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ScoreViewController.endofThirdRound(_:)), name: "endOfRoundThree", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ScoreViewController.endOfFourthRound(_:)), name: "endOfRoundFour", object: nil)
        
        
        scoreLabel.text = "Score: \(overallGameScore)"
        
    }
    
    
    func endOfFirstRound (notification: NSNotification) {
        if case 0 ... 4 = roundOne {
            levelLabel.text = "Never Been Heah"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "never_been_heah.png")!)
        }
        if case 5 ... 8 = roundOne {
            levelLabel.text = "One Timah"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "one_timah.png")!)
        }
        if case 9 ... 11 = roundOne {
            levelLabel.text = "Weekend Warrior"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "weekend_warrior.png")!)
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
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "true_blue_mainah.png")!)
        }
        
        currentRound = 1
        
    }
    
    func endofSecondRound (notification: NSNotification) {
        if case 0 ... 12 = roundTwo {
            levelLabel.text = "Never Been Heah"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "never_been_heah.png")!)
        }
        if case 12 ... 16 = roundTwo {
            levelLabel.text = "One Timah"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "one_timah.png")!)
        }
        if case 17 ... 25 = roundTwo {
            levelLabel.text = "Weekend Warrior"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "weekend_warrior.png")!)
        }
        if case 26 ... 36 = roundTwo {
            levelLabel.text = "Transplant"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "Transplant.png")!)
        }
        if case 37 ... 47 = roundTwo{
            levelLabel.text = "Mainah"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "mainah.png")!)
        }
        if case 48 ... 80 = roundTwo {
            levelLabel.text = "TRUE BLUE MAINAH"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "true_blue_mainah.png")!)
        }
        currentRound = 2
    }
    
    func endofThirdRound (notification: NSNotification) {
        if case 0 ... 4 = roundThree {
            levelLabel.text = "Never Been Heah"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "never_been_heah.png")!)
        }
        if case 5 ... 8 = roundThree {
            levelLabel.text = "One Timah"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "one_timah.png")!)
        }
        if case 9 ... 11 = roundThree {
            levelLabel.text = "Weekend Warrior"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "weekend_warrior.png")!)
        }
        if case 12 ... 15 = roundThree {
            levelLabel.text = "Transplant"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "Transplant.png")!)
        }
        if case 16 ... 20 = roundThree{
            levelLabel.text = "Mainah"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "mainah.png")!)
        }
        if case 21 ... 35 = roundThree {
            levelLabel.text = "TRUE BLUE MAINAH"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "true_blue_mainah.png")!)
        }
        currentRound = 3
    }
    
    func endOfFourthRound (notification: NSNotification) {
        if case 0 ... 4 = roundFour {
            levelLabel.text = "Never Been Heah"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "never_been_heah.png")!)
        }
        if case 5 ... 8 = roundFour {
            levelLabel.text = "One Timah"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "one_timah.png")!)
        }
        if case 9 ... 11 = roundFour {
            levelLabel.text = "Weekend Warrior"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "weekend_warrior.png")!)
        }
        if case 12 ... 15 = roundFour {
            levelLabel.text = "Transplant"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "Transplant.png")!)
        }
        if case 16 ... 20 = roundFour{
            levelLabel.text = "Mainah"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "mainah.png")!)
        }
        if case 21 ... 35 = roundFour {
            levelLabel.text = "TRUE BLUE MAINAH"
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "true_blue_mainah.png")!)
        }
        currentRound = 4
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
