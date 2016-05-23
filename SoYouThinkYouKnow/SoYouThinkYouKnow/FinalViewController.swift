//
//  FinalViewController.swift
//  SoYouThinkYouKnow
//
//  Created by Eric Chamberlin on 3/9/16.
//  Copyright © 2016 Eric Chamberlin. All rights reserved.
//

import UIKit
import Social
import GameplayKit
import GameKit
import GameController
import AVKit
import AVFoundation


class FinalViewController: UIViewController {

    @IBOutlet weak var roundOneImage: UIImageView!
    @IBOutlet weak var roundTwoImage: UIImageView!
    @IBOutlet weak var roundThreeImage: UIImageView!
    
    @IBOutlet weak var newRoundFourImage: SpringImageView!
    @IBOutlet weak var bonusPointsEarned: SpringLabel!
    @IBOutlet weak var bonusCoin: UIImageView!
    @IBOutlet weak var roundFourImage: UIImageView!
    @IBOutlet weak var finalScoreImage: UIImageView!
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
    
    var bonus = Scoring.sharedGameData.bonusPoints
    var audioplayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        
        self.view.addSubview(roundOneImage)
        self.view.addSubview(roundTwoImage)
        self.view.addSubview(roundThreeImage)
        self.view.addSubview(newRoundFourImage)
        self.view.addSubview(finalScoreImage)
        
        //to show percentile 
        // = \(Double(Scoring.sharedGameData.tfscore) / 40)%
        
        roundOneScore.text = "True-False: \(Scoring.sharedGameData.tfscore)"
        roundTwoScore.text = "Multiple Choice: \(Scoring.sharedGameData.mcscore)"
        roundThreeScore.text = "Photos: \(Scoring.sharedGameData.photoscore)"
        roundFourScore.text = "Maps: \(Scoring.sharedGameData.mapsscore)"
        finalScoreLabel2.text = "Final Score: \(Scoring.sharedGameData.overallscore)"
        bonusPointsEarned.text = ("Bonus Points: \(Scoring.sharedGameData.bonusPoints)")
    
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FinalViewController.bonusAdded(_:)), name: "bonusPointAdded", object: nil)
        self.view.addSubview(bonusCoin)
        endOfFirstRound ()
        endOfFourthRound ()
        endofSecondRound ()
        endofThirdRound ()
        overallScore ()
    
    }
    
    override func viewDidAppear(animated: Bool) {
        finalAudio()
    }
    func bonusAdded(notification: NSNotification) {
       
        
        self.bonusCoin.backgroundColor = UIColor(patternImage: UIImage(named: "bonus_coin1.png")!)
        
    }
    
    
    func endOfFirstRound () {
        
        print("we got the score from round one")
        
        if case 0 ... 4 = Scoring.sharedGameData.tfscore {
                roundOneImage.backgroundColor = UIColor(patternImage: UIImage(named: "never1small.png")!)
        }
        if case 5 ... 8 = Scoring.sharedGameData.tfscore {
            roundOneImage.backgroundColor = UIColor(patternImage: UIImage(named: "onetimahsmall.png")!)
        }
        if case 9 ... 11 = Scoring.sharedGameData.tfscore {
            roundOneImage.backgroundColor = UIColor(patternImage: UIImage(named: "weekendwarriorsmall.png")!)
        }
        if case 12 ... 15 = Scoring.sharedGameData.tfscore {
            roundOneImage.backgroundColor = UIColor(patternImage: UIImage(named: "Transplantsmall.png")!)
        }
        if case 16 ... 20 = Scoring.sharedGameData.tfscore{
           roundOneImage.backgroundColor = UIColor(patternImage: UIImage(named: "mainahsmall.png")!)
        }
        if case 21 ... 50 = Scoring.sharedGameData.tfscore {
            roundOneImage.backgroundColor = UIColor(patternImage: UIImage(named: "truebluesmall.png")!)
        }
        
    }
    
    func endofSecondRound () {
        
        print("we got the score from round two")
        
        if case 0 ... 4 = roundTwo {
            roundTwoImage.backgroundColor = UIColor(patternImage: UIImage(named: "never1small.png")!)
        }
        if case 5 ... 9 = roundTwo {
           roundTwoImage.backgroundColor = UIColor(patternImage: UIImage(named: "onetimahsmall.png")!)
        }
        if case 10 ... 17 = roundTwo {
            roundTwoImage.backgroundColor = UIColor(patternImage: UIImage(named: "weekendwarriorsmall.png")!)
        }
        if case 18 ... 25 = roundTwo {
            roundTwoImage.backgroundColor = UIColor(patternImage: UIImage(named: "Transplantsmall.png")!)
        }
        if case 26 ... 33 = roundTwo{
            roundTwoImage.backgroundColor = UIColor(patternImage: UIImage(named: "mainahsmall.png")!)
        }
        if case 34 ... 40 = roundTwo {
            roundTwoImage.backgroundColor = UIColor(patternImage: UIImage(named: "truebluesmall.png")!)
        }
        
    }
    
    func endofThirdRound () {
        print("we got the score from round three")
        if case 0 ... 30 = roundThree {
           roundThreeImage.backgroundColor = UIColor(patternImage: UIImage(named: "never1small.png")!)
        }
        if case 31 ... 45 = roundThree {
            roundThreeImage.backgroundColor = UIColor(patternImage: UIImage(named: "onetimahsmall.png")!)
        }
        if case 46 ... 100 = roundThree {
           roundThreeImage.backgroundColor = UIColor(patternImage: UIImage(named: "weekendwarriorsmall.png")!)
        }
        if case 101 ... 200 = roundThree {
            roundThreeImage.backgroundColor = UIColor(patternImage: UIImage(named: "Transplantsmall.png")!)
        }
        if case 201 ... 400 = roundThree{
            roundThreeImage.backgroundColor = UIColor(patternImage: UIImage(named: "mainahsmall.png")!)
        }
        if case 401 ... 1500 = roundThree {
            roundThreeImage.backgroundColor = UIColor(patternImage: UIImage(named: "truebluesmall.png")!)
        }
       
    }
    
    func endOfFourthRound () {
        print("we got the score from round four")
        
        if case 0 ... 150 = roundFour {
            newRoundFourImage.backgroundColor = UIColor(patternImage: UIImage(named: "never1small.png")!)
        }
        if case 150 ... 299 = roundFour {
            newRoundFourImage.backgroundColor = UIColor(patternImage: UIImage(named: "onetimahsmall.png")!)
        }
        if case 300 ... 499 = roundFour {
            newRoundFourImage.backgroundColor = UIColor(patternImage: UIImage(named: "weekendwarriorsmall.png")!)
        }
        if case 500 ... 649 = roundFour {
            newRoundFourImage.backgroundColor = UIColor(patternImage: UIImage(named: "Transplantsmall.png")!)
        }
        if case 650 ... 799 = roundFour{
            newRoundFourImage.backgroundColor = UIColor(patternImage: UIImage(named: "mainahsmall.png")!)
        }
        if case 800 ... 1000 = roundFour {
            newRoundFourImage.backgroundColor = UIColor(patternImage: UIImage(named: "truebluesmall.png")!)
        }
       
        
    }
    
    func overallScore () {
        
        Scoring.sharedGameData.overallscore = roundFour
        print(Scoring.sharedGameData.tfscore)
        print(Scoring.sharedGameData.mcscore)
        print(Scoring.sharedGameData.photoscore)
        print(Scoring.sharedGameData.mapsscore)
    print(Scoring.sharedGameData.overallscore)
        print(Scoring.sharedGameData.bonusPoints)
        
        if case 0 ... 150 = Scoring.sharedGameData.overallscore {
            if (UIDevice.currentDevice().userInterfaceIdiom == .Phone) {
                //iPhone
                if Device.IS_3_5_INCHES() {
                    //iPhone 4
                    finalScoreImage.backgroundColor = UIColor(patternImage: UIImage(named: "never1final125.png")!)
                } else if Device.IS_4_INCHES() {
                    //iPhone 5
                    finalScoreImage.backgroundColor = UIColor(patternImage: UIImage(named: "never1final125.png")!)
                } else if Device.IS_4_7_INCHES() {
                    //iPhone 6
                    finalScoreImage.backgroundColor = UIColor(patternImage: UIImage(named: "never1final196.png")!)
                } else {
                    if Device.IS_5_5_INCHES() {
                        //iPhone 6plus
                        finalScoreImage.backgroundColor = UIColor(patternImage: UIImage(named: "never1final.png")!)
                    }
                }
            }
            if (UIDevice.currentDevice().userInterfaceIdiom == .Pad) {
                finalScoreImage.backgroundColor = UIColor(patternImage: UIImage(named: "never1final.png")!)
            }
            
        }
        if case 150 ... 299 = Scoring.sharedGameData.overallscore {
            finalScoreImage.backgroundColor = UIColor(patternImage: UIImage(named: "onetimahfinal.png")!)
        }
        if case 300 ... 499 = Scoring.sharedGameData.overallscore {
            finalScoreImage.backgroundColor = UIColor(patternImage: UIImage(named: "weekendwarriorfinal.png")!)
        }
        if case 500 ... 649 = Scoring.sharedGameData.overallscore {
            finalScoreImage.backgroundColor = UIColor(patternImage: UIImage(named: "Transplantfinal.png")!)
        }
        if case 650 ... 799 = Scoring.sharedGameData.overallscore{
            finalScoreImage.backgroundColor = UIColor(patternImage: UIImage(named: "mainahfinal.png")!)
        }
        if case 800 ... 4000 = Scoring.sharedGameData.overallscore {
            finalScoreImage.backgroundColor = UIColor(patternImage: UIImage(named: "trueblue1final.png")!)
        }
        
    }
    
    func finalAudio() {
        do {
            audioPlayer =  try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("share_score_mc", ofType: "aiff")!))
            
            audioPlayer!.play()
            
        } catch {
            print("Error")
        }
    }
    
    @IBAction func tweetButton(sender: AnyObject) {
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
            
            let screen = UIScreen.mainScreen()
            
            if let window = UIApplication.sharedApplication().keyWindow {
                UIGraphicsBeginImageContextWithOptions(screen.bounds.size, false, 0);
                window.drawViewHierarchyInRect(window.bounds, afterScreenUpdates: false)
                let image = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                
                let composeSheet = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                composeSheet.setInitialText("My high score on So you Think you know Maine...can you beat it?? Go download it from the App store!! #soyouthinkyouknowmaine")
                composeSheet.addImage(image)
                
                presentViewController(composeSheet, animated: true, completion: nil)
            
        } else {
            
            var alert = UIAlertController(title: "Accounts", message: "Please login to a Twitter account to tweet.", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    }
    
    /*
    @IBAction func fbButton(sender: AnyObject) {
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
            var fbShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            
            self.presentViewController(fbShare, animated: true, completion: nil)
            
        } else {
            var alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share.", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    */
    
    
    @IBAction func fbScreenShotShare(sender: AnyObject) {
        
        let screen = UIScreen.mainScreen()
        
        if let window = UIApplication.sharedApplication().keyWindow {
            UIGraphicsBeginImageContextWithOptions(screen.bounds.size, false, 0);
            window.drawViewHierarchyInRect(window.bounds, afterScreenUpdates: false)
            let image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            let composeSheet = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            composeSheet.setInitialText("My high score on So you Think you know Maine...can you beat it?? Go download it from the App store!!")
            composeSheet.addImage(image)
            
            presentViewController(composeSheet, animated: true, completion: nil)
        }
        
    }
        /*
        var postPhrase = "New high score \((Scoring.sharedGameData.overallscore))!"
        
        //Generate the screenshot
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        var image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        var postImage = UIImage(named: "\(image)")
        
        let shareToFacebook = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        shareToFacebook.setInitialText(postPhrase)
        shareToFacebook.addImage(postImage)
        presentViewController(shareToFacebook, animated: true, completion: nil)
 */
    
    
    @IBAction func gameCenter(sender: AnyObject) {
        saveHighscore(Scoring.sharedGameData.overallscore)
        showLeaderBoard()
    }
    
    func authPlayer(){
        let localPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {
            (view, error) in
            
            if view != nil {
                
                self.presentViewController(view!, animated: true, completion: nil)
                
            }
            else {
                
                print(GKLocalPlayer.localPlayer().authenticated)
                
            }
            
            
        }
    }
    
    
    func saveHighscore(number : Int){
        
        if GKLocalPlayer.localPlayer().authenticated {
            
            let scoreReporter = GKScore(leaderboardIdentifier: "TopMainah")
            
            scoreReporter.value = Int64(number)
            
            let scoreArray : [GKScore] = [scoreReporter]
            
            GKScore.reportScores(scoreArray, withCompletionHandler: nil)
            
        }
        
        
    }
    
    func showLeaderBoard(){
        let viewController = self.view.window?.rootViewController
        let gcvc = GKGameCenterViewController()
        
        //gcvc.gameCenterDelegate = self
       
        
        dispatch_async(dispatch_get_main_queue(), {() -> Void in
            self.presentViewController(gcvc, animated: true, completion: { _ in })
        })
        
        //viewController?.presentViewController(gcvc, animated: true, completion: nil)
    }
    
    
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func scoreSizes () {
        if (UIDevice.currentDevice().userInterfaceIdiom == .Phone) {
            //iPhone
            if Device.IS_3_5_INCHES() {
                //iPhone 4
            finalScoreImage.backgroundColor = UIColor(patternImage: UIImage(named: "never1final125.png")!)
            } else if Device.IS_4_INCHES() {
                //iPhone 5
                finalScoreImage.backgroundColor = UIColor(patternImage: UIImage(named: "never1final125.png")!)
            } else if Device.IS_4_7_INCHES() {
                //iPhone 6
                finalScoreImage.backgroundColor = UIColor(patternImage: UIImage(named: "never1final196.png")!)
            } else {
                if Device.IS_5_5_INCHES() {
                    //iPhone 6plus
                    finalScoreImage.backgroundColor = UIColor(patternImage: UIImage(named: "never1final.png")!)
                }
            }
        }
        
        if (UIDevice.currentDevice().userInterfaceIdiom == .Pad) {
            finalScoreImage.backgroundColor = UIColor(patternImage: UIImage(named: "never1final.png")!)
        }

}
}
