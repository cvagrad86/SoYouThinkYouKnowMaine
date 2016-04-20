//
//  ScoreViewController.swift
//  SoYouThinkYouKnow
//
//  Created by Eric Chamberlin on 3/9/16.
//  Copyright © 2016 Eric Chamberlin. All rights reserved.
//

import UIKit
import GameKit
import GoogleMobileAds

class ScoreViewController: UIViewController {

    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var yourScoreLabel: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    @IBOutlet weak var nextRoundImage: UIImageView!
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
        
        
        bannerView.adUnitID = "ca-app-pub-2234370748694357/4389721028"
        bannerView.rootViewController = self
        bannerView.loadRequest(GADRequest())
    }
    
    
    func endOfFirstRound (notification: NSNotification) {
       print("round one score has been tallied")
        
        nextRoundImage.backgroundColor = UIColor(patternImage: UIImage(named: "mult_choice.png")!)
        
        
        scoreLabel.text = "Score: \(roundOne)"
        
        if case 0 ... 4 = roundOne {
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "never1.png")!)
        }
        if case 5 ... 8 = roundOne {
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "onetimah.png")!)
        }
        if case 9 ... 11 = roundOne {
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "weekendwarrior.png")!)
        }
        if case 12 ... 15 = roundOne {
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "Transplant.png")!)
        }
        if case 16 ... 20 = roundOne{
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "mainah.png")!)
        }
        if case 21 ... 50 = roundOne {
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "trueblue1.png")!)
        }
        
        currentRound = 1
        print(currentRound)
        
    }
    
    func endofSecondRound (notification: NSNotification) {
       print("round two score has been tallied")
        
        nextRoundImage.backgroundColor = UIColor(patternImage: UIImage(named: "name_that_photo.png")!)
        
        scoreLabel.text = "Score: \(roundTwo)"
        
        if case 0 ... 4 = roundTwo {
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "never1.png")!)
        }
        if case 5 ... 9 = roundTwo {
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "onetimah.png")!)
        }
        if case 10 ... 17 = roundTwo {
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "weekendwarrior.png")!)
        }
        if case 18 ... 25 = roundTwo {
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "Transplant.png")!)
        }
        if case 26 ... 33 = roundTwo{
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "mainah.png")!)
        }
        if case 34 ... 40 = roundTwo {
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "trueblue1.png")!)
        }
        currentRound = 2
        print(currentRound)
    }
    
    func endofThirdRound (notification: NSNotification) {
        
        print("round three score has been tallied")
        
        nextRoundImage.backgroundColor = UIColor(patternImage: UIImage(named: "maine_maps.png")!)
        
        scoreLabel.text = "Score: \(roundThree)"
        
        
        if case 0 ... 30 = roundThree {
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "never1.png")!)
        }
        if case 31 ... 45 = roundThree {
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "onetimah.png")!)
        }
        if case 46 ... 100 = roundThree {
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "weekendwarrior.png")!)
        }
        if case 101 ... 200 = roundThree {
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "Transplant.png")!)
        }
        if case 201 ... 400 = roundThree{
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "mainah.png")!)
        }
        if case 401 ... 1500 = roundThree {
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "trueblue1.png")!)
        }
        currentRound = 3
        print(currentRound)
        
    }
    
    func endOfFourthRound (notification: NSNotification) {
        
       print("round four score has been tallied")
        
        scoreLabel.text = "Score: \(roundFour)"
        
        if case 0 ... 150 = roundFour {
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "never1.png")!)
        }
        if case 150 ... 299 = roundFour {
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "onetimah.png")!)
        }
        if case 300 ... 499 = roundFour {
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "weekendwarrior.png")!)
        }
        if case 500 ... 649 = roundFour {
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "Transplant.png")!)
        }
        if case 650 ... 799 = roundFour{
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "mainah.png")!)
        }
        if case 800 ... 1000 = roundFour {
            yourScoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "trueblue1.png")!)
        }
        currentRound = 4
        print(currentRound)
        
        
        nextRoundImage.backgroundColor = UIColor(patternImage: UIImage(named: "the_end_sign copy.png")!)
        
        Scoring.sharedGameData.overallscore = roundFour
    }
    
    
    
    
    @IBAction func nextRound(sender: AnyObject) {
        
        var vc: UIViewController?
        
        if currentRound == 1 {
            //go to Mult Choice vc
            
            vc = storyboard?.instantiateViewControllerWithIdentifier("multipleChoiceViewController") as! MultipleChoiceViewController
            
            self.presentViewController(vc!, animated: true, completion: nil)
            
        } else if currentRound == 2 {
            //go to Photos vc

            vc = storyboard?.instantiateViewControllerWithIdentifier("photosViewController") as! PhotosViewController
            
            self.presentViewController(vc!, animated: true, completion: nil)
            
            print("it is time to go to Photos")
            
        } else if currentRound == 3 {
            //go to Maps vc

            vc = storyboard?.instantiateViewControllerWithIdentifier("mapsViewController") as! MapsViewController
            
            self.presentViewController(vc!, animated: true, completion: nil)
            
        } else if currentRound == 4 {
            
            //game over go to final vc
            
            vc = storyboard?.instantiateViewControllerWithIdentifier("finalViewController") as! FinalViewController
            
            self.presentViewController(vc!, animated: true, completion: nil)
            
        }
    }
    
    
    
}
