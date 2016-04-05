//
//  ViewController.swift
//  pictureTest
//
//  Created by Eric Chamberlin on 2/23/16.
//  Copyright © 2016 Eric Chamberlin. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    var counter = 0
    var currentScore = 0
    var startTime = NSTimeInterval()
    var timer:NSTimer?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userScore: UILabel!
    @IBOutlet weak var nextQuestionButton: UIButton!
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var correctAnswer: String?
    var answers = [String]()
    var image: String?
    var questionIdx = 0

    @IBOutlet var pictureTiles: [UILabel]!
    @IBOutlet var buttonHandler: [UIButton]!
    @IBOutlet weak var startButton: UIButton!
    @IBAction func answerButtonHandler(sender: UIButton) {
        
        if sender.titleLabel!.text == correctAnswer {
            timer!.invalidate()
            timerLabel.hidden = true
            userScore.text = "Your score = \(counter * 5)"
            currentScore = currentScore + (counter * 5)
            sender.backgroundColor = UIColor.greenColor()
            nextQuestionButton.hidden = false
            
            nextQuestionButton.transform = CGAffineTransformMakeScale(0.9, 0.9)
            
            UIView.animateWithDuration(2.0,
                                       delay: 0,
                                       usingSpringWithDamping: 0.70,
                                       initialSpringVelocity: 10.00,
                                       options: UIViewAnimationOptions.AllowUserInteraction,
                                       animations: {
                                        self.nextQuestionButton.transform = CGAffineTransformIdentity
                }, completion: nil)
            
        } else {
            sender.backgroundColor = UIColor.redColor()
            counter += 2
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        nextQuestionButton.hidden = true
        
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
        
        imgArray!.shuffle()
        timerLabel.hidden = true
        
    }
    func updateScore() {
        //currentScore
    }
    
    @IBAction func callNextPhoto(sender: AnyObject) {
        if questionIdx < imgArray!.count - 1 {
            questionIdx += 1
        } else {
            showAlert()
        }
        //nextQuestion()
        unHide()
        startButton.hidden = false
        updateTime()
        
        timerLabel.hidden = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func updateTime() {
        
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        var elapsedTime: NSTimeInterval = currentTime
        let minutes = UInt64(elapsedTime / 60.0)
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        let seconds = UInt64(elapsedTime)
        elapsedTime -= NSTimeInterval(seconds)
        let fraction = UInt64(elapsedTime * 100)
        _ = String(format: "%02d", minutes)
        _ = String(format: "%02d", seconds)
        _ = String(format: "%02d", fraction)
        
        
    }
    
    @IBAction func revealButton(sender: AnyObject) {
        nextQuestion()
        startButton.hidden = true
        Hide()
        updateTime()
        let aSelector : Selector = #selector(PhotosViewController.timerAction)
        timer = NSTimer.scheduledTimerWithTimeInterval(1.00, target:self, selector: aSelector,     userInfo: nil, repeats: true)
        startTime = NSDate.timeIntervalSinceReferenceDate()
        
    }
    
    func nextQuestion () {
        let currentQuestion = imgArray![questionIdx]
        answers = currentQuestion["Answers"] as! [String]
        correctAnswer = currentQuestion["CorrectAnswer"] as? String
        image = currentQuestion["Image"] as? String
        titlesForButtons()
        nextQuestionButton.hidden = false
    }
    
    func titlesForButtons() {
        
        for (idx,button) in buttonHandler.enumerate() {
            button.setTitle(answers[idx], forState: .Normal)
            button.titleLabel!.lineBreakMode = .ByWordWrapping
            button.titleLabel!.textAlignment = .Center
            button.enabled = true
            button.backgroundColor = UIColor(red: 83.0/255.0, green: 184.0/255.0, blue: 224.0/255.0, alpha: 1.0)
        }
        
        imageView.image = UIImage(named: image!)
    }
    
    
    //Mark timer
    
    func timerAction() {
        counter += 1
        timerLabel.text = "\(timer?.timeInterval)"
    }
    
    func resetTimer(){
        let aSelector : Selector = #selector(PhotosViewController.timerAction)
        timer!.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: aSelector , userInfo: nil , repeats: false)
        startTime = NSDate.timeIntervalSinceReferenceDate()
       
    }
    
    func unHide() {
        
        let numberOfTiles = self.pictureTiles
        
        let duration = 0.01
        let options = UIViewAnimationOptions.CurveEaseOut
        let delay = 0.01
        //NSTimeInterval(900 + arc4random_uniform(100)) / 1000
        
        for _ in numberOfTiles {
            UIView.animateWithDuration(duration, delay: delay, options: options, animations: {
                let randomIndex = arc4random_uniform(UInt32(self.pictureTiles.count))
                let randomTile = self.pictureTiles[randomIndex.hashValue]
                randomTile.alpha = 1.0
                
                
                }, completion: { animationFinished in
                    let randomIndex = arc4random_uniform(UInt32(self.pictureTiles.count))
                    let randomTile = self.pictureTiles[randomIndex.hashValue]
                    
                    randomTile.alpha = 1.0
                    
            })
        }
    }

   
    
    func Hide() {
        
       let numberOfTiles = self.pictureTiles
        
        let duration = 4.0
        let options = UIViewAnimationOptions.CurveEaseOut
        let delay = 4.0
        //NSTimeInterval(900 + arc4random_uniform(100)) / 1000
        
        for _ in numberOfTiles {
            UIView.animateWithDuration(duration, delay: delay, options: options, animations: {
                let randomIndex = arc4random_uniform(UInt32(self.pictureTiles.count))
                let randomTile = self.pictureTiles[randomIndex.hashValue]
                randomTile.alpha = 0.0
                
                
                }, completion: { animationFinished in
                    let randomIndex = arc4random_uniform(UInt32(self.pictureTiles.count))
                    let randomTile = self.pictureTiles[randomIndex.hashValue]
                    
                    randomTile.alpha = 0.0
                    
            })
        }
    }
    
    func showAlert() {
        //var vc: UIViewController?
        let alertController = UIAlertController(title: "Thats all the photos", message: "Let's see how you did", preferredStyle: UIAlertControllerStyle.Alert)
        
        let ok = UIAlertAction(title: "Ayuh", style: .Default, handler: { (alert: UIAlertAction!) in
            
            self.performSegueWithIdentifier("ScoreSegue", sender: self)
            //vc = self.storyboard?.instantiateViewControllerWithIdentifier("scoreViewController") as! ScoreViewController
        })
        
        alertController.addAction(ok)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    
    
}
