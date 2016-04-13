//
//  FinalViewController.swift
//  SoYouThinkYouKnow
//
//  Created by Eric Chamberlin on 3/9/16.
//  Copyright © 2016 Eric Chamberlin. All rights reserved.
//

import UIKit

class FinalViewController: UIViewController {

    
    @IBOutlet weak var roundOneLabel: UILabel!
    @IBOutlet weak var roundOneScore: UILabel!
    @IBOutlet weak var roundTwoLabel: UILabel!
    @IBOutlet weak var roundTwoScore: UILabel!
    @IBOutlet weak var roundThreeLabel: UILabel!
    @IBOutlet weak var roundThreeScore: UILabel!
    @IBOutlet weak var roundFourLabel: UILabel!
    @IBOutlet weak var roundFourScore: UILabel!
    @IBOutlet weak var overallScoreLabel: UILabel!
    @IBOutlet weak var finalScoreLabel2: UILabel!
    
    var roundOne = Scoring.sharedGameData.tfscore
    var roundTwo = (Scoring.sharedGameData.tfscore + Scoring.sharedGameData.mcscore)
    var roundThree = (Scoring.sharedGameData.tfscore + Scoring.sharedGameData.mcscore + Scoring.sharedGameData.photoscore)
    var roundFour = (Scoring.sharedGameData.tfscore + Scoring.sharedGameData.mcscore + Scoring.sharedGameData.photoscore + Scoring.sharedGameData.mapsscore)
    
    
    override func viewDidLoad() {
    
        roundOneScore.text = "\(Scoring.sharedGameData.tfscore)"
        roundTwoScore.text = "\(Scoring.sharedGameData.mcscore)"
        roundThreeScore.text = "\(Scoring.sharedGameData.photoscore)"
        roundFourScore.text = "\(Scoring.sharedGameData.mapsscore)"
        overallScoreLabel.text = "\(Scoring.sharedGameData.overallscore)"
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FinalViewController.endOfFirstRound(_:)), name: "endOfRoundOne", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FinalViewController.endofSecondRound(_:)), name: "endOfRoundTwo", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FinalViewController.endofThirdRound(_:)), name: "endOfRoundThree", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FinalViewController.endOfFourthRound(_:)), name: "endOfRoundFour", object: nil)
        
        overallScore ()
    }
    
    func endOfFirstRound (notification: NSNotification) {
        
        
        
        if case 0 ... 4 = roundOne {
                roundOneLabel.backgroundColor = UIColor(patternImage: UIImage(named: "never1.png")!)
        }
        if case 5 ... 8 = roundOne {
            roundOneLabel.backgroundColor = UIColor(patternImage: UIImage(named: "onetimah.png")!)
        }
        if case 9 ... 11 = roundOne {
            roundOneLabel.backgroundColor = UIColor(patternImage: UIImage(named: "weekendwarrior.png")!)
        }
        if case 12 ... 15 = roundOne {
            roundOneLabel.backgroundColor = UIColor(patternImage: UIImage(named: "Transplant.png")!)
        }
        if case 16 ... 20 = roundOne{
           roundOneLabel.backgroundColor = UIColor(patternImage: UIImage(named: "mainah.png")!)
        }
        if case 21 ... 50 = roundOne {
            roundOneLabel.backgroundColor = UIColor(patternImage: UIImage(named: "trueblue1.png")!)
        }
        
    }
    
    func endofSecondRound (notification: NSNotification) {
        
        if case 0 ... 4 = roundTwo {
            roundTwoLabel.backgroundColor = UIColor(patternImage: UIImage(named: "never1.png")!)
        }
        if case 5 ... 9 = roundTwo {
           roundTwoLabel.backgroundColor = UIColor(patternImage: UIImage(named: "onetimah.png")!)
        }
        if case 10 ... 17 = roundTwo {
            roundTwoLabel.backgroundColor = UIColor(patternImage: UIImage(named: "weekendwarrior.png")!)
        }
        if case 18 ... 25 = roundTwo {
            roundTwoLabel.backgroundColor = UIColor(patternImage: UIImage(named: "Transplant.png")!)
        }
        if case 26 ... 33 = roundTwo{
            roundTwoLabel.backgroundColor = UIColor(patternImage: UIImage(named: "mainah.png")!)
        }
        if case 34 ... 40 = roundTwo {
            roundTwoLabel.backgroundColor = UIColor(patternImage: UIImage(named: "trueblue1.png")!)
        }
        
    }
    
    func endofThirdRound (notification: NSNotification) {
        
        if case 0 ... 30 = roundThree {
           roundThreeLabel.backgroundColor = UIColor(patternImage: UIImage(named: "never1.png")!)
        }
        if case 31 ... 45 = roundThree {
            roundThreeLabel.backgroundColor = UIColor(patternImage: UIImage(named: "onetimah.png")!)
        }
        if case 46 ... 100 = roundThree {
           roundThreeLabel.backgroundColor = UIColor(patternImage: UIImage(named: "weekendwarrior.png")!)
        }
        if case 101 ... 200 = roundThree {
            roundThreeLabel.backgroundColor = UIColor(patternImage: UIImage(named: "Transplant.png")!)
        }
        if case 201 ... 400 = roundThree{
            roundThreeLabel.backgroundColor = UIColor(patternImage: UIImage(named: "mainah.png")!)
        }
        if case 401 ... 1500 = roundThree {
            roundThreeLabel.backgroundColor = UIColor(patternImage: UIImage(named: "trueblue1.png")!)
        }
       
    }
    
    func endOfFourthRound (notification: NSNotification) {

        if case 0 ... 150 = roundFour {
            roundFourLabel.backgroundColor = UIColor(patternImage: UIImage(named: "never1.png")!)
        }
        if case 150 ... 299 = roundFour {
            roundFourLabel.backgroundColor = UIColor(patternImage: UIImage(named: "onetimah.png")!)
        }
        if case 300 ... 499 = roundFour {
            roundFourLabel.backgroundColor = UIColor(patternImage: UIImage(named: "weekendwarrior.png")!)
        }
        if case 500 ... 649 = roundFour {
            roundFourLabel.backgroundColor = UIColor(patternImage: UIImage(named: "Transplant.png")!)
        }
        if case 650 ... 799 = roundFour{
            roundFourLabel.backgroundColor = UIColor(patternImage: UIImage(named: "mainah.png")!)
        }
        if case 800 ... 1000 = roundFour {
            roundFourLabel.backgroundColor = UIColor(patternImage: UIImage(named: "trueblue1.png")!)
        }
       
        
    }
    
    func overallScore () {
        
        Scoring.sharedGameData.overallscore = roundFour
    }

}
