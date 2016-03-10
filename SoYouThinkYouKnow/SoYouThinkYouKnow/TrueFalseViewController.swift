//
//  TrueFalseViewController.swift
//  SoYouThinkYouKnow
//
//  Created by Eric Chamberlin on 3/9/16.
//  Copyright © 2016 Eric Chamberlin. All rights reserved.
//

import UIKit

class TrueFalseViewController: UIViewController {
    
    @IBOutlet var questionLabel: UILabel!
    
    @IBOutlet var answerButtons: [UIButton]!
    
    @IBOutlet var cardButton: UIButton!
    
    @IBOutlet weak var nopeButton: UIButton!
    @IBOutlet weak var ayuhButton: UIButton!
    @IBAction func answerButtonHandler(sender: UIButton) {
        if sender.titleLabel!.text == correctAnswer {
            
        } else {
            sender.backgroundColor = UIColor.redColor()
            
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
            questionIdx++
        } else {
            questionIdx = 0
        }
        nextQuestion()
    }
    
    var correctAnswer: String?
    
    var question: String?
    
    var answers = ["Wrong","Right"]
    
    var questionIdx = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.questionLabel.layer.borderWidth = 3
        self.questionLabel.layer.borderColor = UIColor.blackColor().CGColor
        self.ayuhButton.layer.borderWidth = 1
        self.ayuhButton.layer.borderColor = UIColor.blackColor().CGColor
        self.nopeButton.layer.borderWidth = 1
        self.nopeButton.layer.borderColor = UIColor.blackColor().CGColor
        
        cardButton.enabled = false
        nextQuestion()
        
        //titlesForButtons()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

}
