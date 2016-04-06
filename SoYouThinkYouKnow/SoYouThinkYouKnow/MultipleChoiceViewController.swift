//
//  MultipleChoiceViewController.swift
//  SoYouThinkYouKnow
//
//  Created by Eric Chamberlin on 3/9/16.
//  Copyright © 2016 Eric Chamberlin. All rights reserved.
//

import UIKit

class MultipleChoiceViewController: UIViewController {

    var correctAnswer: String?
    var question: String?
    var answers = [String]()
    var questionIdx = 0
    var Highscore = Int()
    var mcscore = 0
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerButtons: [UIButton]!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!

    @IBAction func answerButtonHandler(sender: UIButton) {
        if sender.titleLabel!.text == correctAnswer {
            mcscore += 2
            scoreLabel.text = "Your score = \(mcscore)"
            print("+2")
                    } else {
            mcscore -= 2
            print("-2")
            scoreLabel.text = "Your score = \(mcscore)"
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
        
    }
    
    func saveScore () {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(mcscore, forKey: "mcscore")
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
        
        titlesForButtons()
    }
    
    func titlesForButtons() {
        for (idx,button) in answerButtons.enumerate() {
            button.titleLabel!.lineBreakMode = .ByWordWrapping
            button.setTitle(answers[idx], forState: .Normal)
            button.enabled = true
            button.titleLabel?.textAlignment = .Center
            button.backgroundColor = UIColor(red: 83.0/255.0, green: 184.0/255.0, blue: 224.0/255.0, alpha: 1.0)
        }
        
        questionLabel.text = question
    }
    
    func showAlert() {
        //var vc: UIViewController?
        let alertController = UIAlertController(title: "Nice job Bub!", message: "Let's see how you did", preferredStyle: UIAlertControllerStyle.Alert)
        
        let ok = UIAlertAction(title: "Ayuh", style: .Default, handler: { (alert: UIAlertAction!) in
            
            self.performSegueWithIdentifier("ScoreSegue", sender: self)
            //vc = self.storyboard?.instantiateViewControllerWithIdentifier("scoreViewController") as! ScoreViewController
        })
        
        alertController.addAction(ok)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }

}
