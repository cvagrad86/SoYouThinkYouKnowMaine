//
//  MultipleChoiceViewController.swift
//  SoYouThinkYouKnow
//
//  Created by Eric Chamberlin on 3/9/16.
//  Copyright © 2016 Eric Chamberlin. All rights reserved.
//

import UIKit
import GoogleMobileAds
import AVKit
import AVFoundation

class MultipleChoiceViewController: UIViewController {

    @IBOutlet weak var bannerView: GADBannerView!
    var correctAnswer: String?
    var question: String?
    var audio: String?
    var correctAudio: String?
    var incorrectAudio: String?
    var answers = [String]()
    var questionIdx = 0
    var Highscore = Int()
    var multchscore = 0
    var inARow = 0
    var bonus = 0
    var mcaudioPlayer: AVAudioPlayer?
    //var queuePlayer: AVQueuePlayer
    var queuePlayer = AVQueuePlayer()
    
   
    @IBOutlet weak var bonusCoin: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerButtons: [UIButton]!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!

    @IBAction func answerButtonHandler(sender: UIButton) {
        if sender.titleLabel!.text == correctAnswer {
            multchscore += 2
            scoreLabel.text = "Your score = \(multchscore)"
            inARow += 1
            createPlayerItem(correctAudio!, ofType: "aiff")
            
            } else {
            multchscore -= 2
            inARow = 0
            scoreLabel.text = "Your score = \(multchscore)"
            sender.backgroundColor = UIColor.redColor()
            createPlayerItem(incorrectAudio!, ofType: "aiff")
            print(inARow)
            
        }
        for button in answerButtons {
            button.enabled = false
            if button.titleLabel!.text == correctAnswer {
                button.backgroundColor = UIColor.greenColor()
            }
        }
        
        
        cardButton.enabled = true
        saveScore()
        Scoring.sharedGameData.mcscore = multchscore
        if self.multchscore < 0 {
            self.multchscore = 0
            Scoring.sharedGameData.mcscore = self.multchscore
        }
        if inARow > 10 {
            //show bonus
            NSNotificationCenter.defaultCenter().postNotificationName("bonusPointAdded", object: self)
            bonusPoints()
        }
    }
    
    @IBOutlet var cardButton: UIButton!
    
    @IBAction func cardButtonHandler(sender: AnyObject) {
        cardButton.enabled = true
        if questionIdx < mcArray!.count - 1 {
            questionIdx += 1
        } else {
            showAlert()
            queuePlayer.pause()
        }
        
        UIView.animateWithDuration(2.0, delay: 2.0, usingSpringWithDamping: 4, initialSpringVelocity: 4, options: UIViewAnimationOptions.AllowAnimatedContent, animations: {
            self.nextQuestion()
            }, completion: nil)
        
        
    }
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(scoreLabel)
        mcArray!.shuffle()
        cardButton.enabled = false
        
        UIView.animateWithDuration(2.0, delay: 2.0, usingSpringWithDamping: 4, initialSpringVelocity: 4, options: UIViewAnimationOptions.AllowAnimatedContent, animations: {
            self.nextQuestion()
            }, completion: nil)
        
        
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.blackColor().CGColor
        button1.layer.cornerRadius = 10
        button1.layer.borderWidth = 2
        button1.layer.borderColor = UIColor.blackColor().CGColor
        
        button2.layer.cornerRadius = 10
        button2.layer.borderWidth = 2
        button2.layer.borderColor = UIColor.blackColor().CGColor
        button3.layer.cornerRadius = 10
        button3.layer.borderWidth = 2
        button3.layer.borderColor = UIColor.blackColor().CGColor
        
        bannerView.adUnitID = "ca-app-pub-2234370748694357/4389721028"
        bannerView.rootViewController = self
        bannerView.loadRequest(GADRequest())

       
        
        self.bonusCoin.hidden = true
        
    }
    
    func saveScore () {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(multchscore, forKey: "mcscore")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func nextQuestion() {
        let currentQuestion = mcArray![questionIdx]
        
        answers = currentQuestion["Answers"] as! [String]
        correctAnswer = currentQuestion["CorrectAnswer"] as? String
        question = currentQuestion["Question"] as? String
        
        cardButton.enabled = false
        titlesForButtons()
        self.bonusCoin.hidden = true
        
        audio = currentQuestion["Audio"] as? String
        correctAudio = currentQuestion["CorrectAudio"] as? String
        incorrectAudio = currentQuestion["IncorrectAudio"] as? String
        
        createPlayerItem(audio!, ofType: "aiff")
        
        
        queuePlayer.play()
        //queuePlayer.removeAllItems()

    }
    
    func createPlayerItem(item: String, ofType type: String) {
        let path = NSBundle.mainBundle().pathForResource(item, ofType: type)
        let url = NSURL.fileURLWithPath(path!)
        let item = AVPlayerItem(URL: url)
        queuePlayer.insertItem(item, afterItem: nil)
        
    }
    
    func bonusAudio () {
        do {
            mcaudioPlayer =  try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bonus_sound1", ofType: "mp3")!))
            
            mcaudioPlayer!.play()
            
        } catch {
            print("Error")
        }
    }
    
    func bonusPoints () {
        
        bonus += 1
        
        Scoring.sharedGameData.bonusPoints = bonus
        inARow = 0 
        self.view.addSubview(bonusCoin)
        
        self.bonusCoin.hidden = false
        
        
        bonusAudio ()
        UIView.animateWithDuration(3.0, delay: 0.0, usingSpringWithDamping: 4, initialSpringVelocity: 4, options: UIViewAnimationOptions.AllowAnimatedContent, animations: {
            self.bonusCoin.transform = CGAffineTransformMakeScale(1.5 , 1.5)
          
            }, completion: nil)
        
        NSNotificationCenter.defaultCenter().postNotificationName("bonusPointAdded", object: self)
        
    }

    
    func titlesForButtons() {
        
        UIView.animateWithDuration(3.5, delay: 0.0, usingSpringWithDamping: 4, initialSpringVelocity: 4, options: UIViewAnimationOptions.AllowAnimatedContent, animations: {
            for (idx,button) in self.answerButtons.enumerate() {
                button.titleLabel!.lineBreakMode = .ByWordWrapping
                button.setTitle(self.answers[idx], forState: .Normal)
                button.enabled = true
                button.titleLabel?.textAlignment = .Center
                button.titleLabel?.numberOfLines = 0
                button.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            }

            
            }, completion: nil)

        
        questionLabel.text = question
    }
    
    func showAlert() {
        //var vc: UIViewController?
        let alertController = UIAlertController(title: "Nice job Bub!", message: "Let's see how you did", preferredStyle: UIAlertControllerStyle.Alert)
        
        let ok = UIAlertAction(title: "Ayuh", style: .Default, handler: { (alert: UIAlertAction!) in
            
            self.performSegueWithIdentifier("ScoreSegue", sender: self)
            
            
            NSNotificationCenter.defaultCenter().postNotificationName("endOfRoundTwo", object: self)
            //vc = self.storyboard?.instantiateViewControllerWithIdentifier("scoreViewController") as! ScoreViewController
        })
        
        alertController.addAction(ok)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }

}
