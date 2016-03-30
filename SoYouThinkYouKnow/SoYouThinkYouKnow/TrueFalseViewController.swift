//
//  TrueFalseViewController.swift
//  SoYouThinkYouKnow
//
//  Created by Eric Chamberlin on 3/9/16.
//  Copyright © 2016 Eric Chamberlin. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class TrueFalseViewController: UIViewController {
    
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet var questionLabel: UILabel!
    
    @IBOutlet var answerButtons: [UIButton]!
    
    @IBOutlet var cardButton: UIButton!
    
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var nopeButton: UIButton!
    @IBOutlet weak var ayuhButton: UIButton!
    
    @IBOutlet var countDownLabel: UILabel!
    
    var audioPlayer: AVAudioPlayer?
    
    var count = 60
    var currentscore = 0
    var timer = NSTimer()
    
    @IBAction func answerButtonHandler(sender: UIButton) {
        if sender.titleLabel!.text == correctAnswer {
            ayuh()
        currentscore++
            
            print("+1")
        } else {
            sender.backgroundColor = UIColor.redColor()
            nope()
            currentscore--
            print("-1")
        }
        for button in answerButtons {
            button.enabled = false
            if button.titleLabel!.text == correctAnswer {
                button.backgroundColor = UIColor.greenColor()
            }
        }
        cardButton.enabled = true
        
    }
    
    @IBAction func cardButtonHandler(sender: AnyObject) {
        cardButton.enabled = true
        if questionIdx < rowArray!.count - 1 {
            questionIdx += 1
        } else {
            questionIdx = 0
        }
        nextQuestion()
        score.text = "Your score = \(currentscore)"
    }
    
    var correctAnswer: String?
    
    var question: String?
    
    var answers = ["Ayuh","Nope"]
    
    var questionIdx = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.questionLabel.layer.borderWidth = 1
        self.questionLabel.layer.borderColor = UIColor.blackColor().CGColor
        self.ayuhButton.layer.borderWidth = 1
        self.ayuhButton.layer.borderColor = UIColor.blackColor().CGColor
        self.nopeButton.layer.borderWidth = 1
        self.nopeButton.layer.borderColor = UIColor.blackColor().CGColor
        startTimer()
        cardButton.enabled = false
        nextQuestion()
        
        let timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(TrueFalseViewController.update), userInfo: nil, repeats: true)
        //titlesForButtons()
        progressBar.transform = CGAffineTransformScale(progressBar.transform, 1, 10)
        
        rowArray!.shuffle()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func ayuh() {
        do {
            audioPlayer =  try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("ayuhSound2", ofType: "mp3")!))
            audioPlayer!.play()
            
        } catch {
            print("Error")
        }
    }
    
    func nope() {
        do {
            audioPlayer =  try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("nope3", ofType: "mp3")!))
            audioPlayer!.play()
            
        } catch {
            print("Error")
        }
    }
    
    func update() {
        
        if(count > 0)
        {
            countDownLabel.text = String(count--)
        }
        
    }
    
    func nextQuestion() {
        let currentQuestion = rowArray![questionIdx]
        
        correctAnswer = currentQuestion["CorrectAnswer"] as? String
        question = currentQuestion["Question"] as? String
        
        titlesForButtons()
    }
    
    func titlesForButtons() {
        for (idx,button) in answerButtons.enumerate() {
            button.setTitle(answers[idx], forState: .Normal)
            button.enabled = true
            button.backgroundColor = UIColor(red: 83.0/255.0, green: 184.0/255.0, blue: 224.0/255.0, alpha: 1.0)
        }
        
        questionLabel.text = question
    }
    func startTimer () {
        progressBar.progress = 1.0
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "updateprogressView", userInfo: nil, repeats: true)
        
    }
    
    func updateprogressView() {
        progressBar.progress -= 0.01/2
        
        if progressBar.progress <= 0 {
            outOfTime()
        }
        
    }
    
    func outOfTime () {
        timer.invalidate()
        showAlert()
        disableButtons()
    }
    
    func disableButtons() {
        for button in answerButtons {
            button.enabled = false
        }
    }
    
    func showAlert() {
        //var vc: UIViewController?
        let alertController = UIAlertController(title: "Maine Minute is up!", message: "Let's see how you did", preferredStyle: UIAlertControllerStyle.Alert)
        
        let ok = UIAlertAction(title: "Ayuh", style: .Default, handler: { (alert: UIAlertAction!) in
            
            self.performSegueWithIdentifier("ScoreSegue", sender: self)
            //vc = self.storyboard?.instantiateViewControllerWithIdentifier("scoreViewController") as! ScoreViewController
        })
        
        alertController.addAction(ok)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    

}
