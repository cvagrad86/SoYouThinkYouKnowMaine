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
    
    @IBOutlet var questionLabel: UILabel!
    
    @IBOutlet var answerButtons: [UIButton]!
    
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
    
    @IBOutlet var cardButton: UIButton!
    
    @IBAction func cardButtonHandler(sender: AnyObject) {
        cardButton.enabled = true
        if questionIdx < mcArray!.count - 1 {
            questionIdx++
        } else {
            questionIdx = 0
        }
        nextQuestion()
    }
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        mcArray!.shuffle()
        cardButton.enabled = false
        nextQuestion()
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
            button.backgroundColor = UIColor(red: 83.0/255.0, green: 184.0/255.0, blue: 224.0/255.0, alpha: 1.0)
        }
        
        questionLabel.text = question
    }
}
