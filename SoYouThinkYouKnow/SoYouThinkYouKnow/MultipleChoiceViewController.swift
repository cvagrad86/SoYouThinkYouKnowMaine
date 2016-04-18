//
//  MultipleChoiceViewController.swift
//  SoYouThinkYouKnow
//
//  Created by Eric Chamberlin on 3/9/16.
//  Copyright © 2016 Eric Chamberlin. All rights reserved.
//

import UIKit
import GoogleMobileAds

class MultipleChoiceViewController: UIViewController {

    @IBOutlet weak var bannerView: GADBannerView!
    var correctAnswer: String?
    var question: String?
    var answers = [String]()
    var questionIdx = 0
    var Highscore = Int()
    var multchscore = 0
    var inARow = 0
    
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
                    } else {
            multchscore -= 2
            inARow = 0
            scoreLabel.text = "Your score = \(multchscore)"
            sender.backgroundColor = UIColor.redColor()
            
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
            
        }
    }
    
    @IBOutlet var cardButton: UIButton!
    
    @IBAction func cardButtonHandler(sender: AnyObject) {
        cardButton.enabled = true
        if questionIdx < mcArray!.count - 1 {
            questionIdx += 1
            
            
        } else {
            showAlert()
        }
        nextQuestion()
        
    }
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(scoreLabel)
        mcArray!.shuffle()
        cardButton.enabled = false
        nextQuestion()
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
    }
    
    func titlesForButtons() {
        for (idx,button) in answerButtons.enumerate() {
            button.titleLabel!.lineBreakMode = .ByWordWrapping
            button.setTitle(answers[idx], forState: .Normal)
            button.enabled = true
            button.titleLabel?.textAlignment = .Center
            button.titleLabel?.numberOfLines = 0
            button.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        }
        
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
