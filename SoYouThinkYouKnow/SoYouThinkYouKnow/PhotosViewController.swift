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
    var timer:NSTimer = NSTimer()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userScore: UILabel!
    @IBOutlet weak var nextQuestionButton: UIButton!
    
    //var mybutton = UIButton!.self
    var correctAnswer: String?
    //[[Actions]] = [[]]
    var answers = [String]()
    var image: String?
    var questionIdx = 0
    
    
    @IBOutlet var pictureTiles: [UILabel]!
    @IBOutlet var buttonHandler: [UIButton]!
    //@IBOutlet weak var myButton: UIButton!
    
    @IBOutlet weak var startButton: UIButton!
    @IBAction func answerButtonHandler(sender: UIButton) {
        
        if sender.titleLabel!.text == correctAnswer {
            timer.invalidate()
            userScore.text = "Your score = \(counter * 5)"
            currentScore = currentScore + (counter * 5)
            timerLabel.hidden = true
            sender.backgroundColor = UIColor.greenColor()
            nextQuestionButton.hidden = false
            
        } else {
            sender.backgroundColor = UIColor.redColor()
            counter += 1
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        nextQuestionButton.hidden = true
        nextQuestion()
        
        
    }
    
    
    @IBAction func callNextPhoto(sender: AnyObject) {
        //cardButton.enabled = true
        if questionIdx < imgArray!.count - 1 {
            questionIdx += 1
        } else {
            showAlert()
        }
        
        nextQuestion()
        unHide()
        startButton.hidden = false
        nextQuestionButton.hidden = true
        updateTime()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func updateTime() {
        
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        var elapsedTime: NSTimeInterval = currentTime - startTime
        
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
    
    func timerAction() {
        counter += 1
        timerLabel.text = "\(counter)"
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
