//
//  ViewController.swift
//  SoYouThinkYouKnow
//
//  Created by Eric Chamberlin on 3/8/16.
//  Copyright © 2016 Eric Chamberlin. All rights reserved.
//


import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var welcomeSign: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.welcomeSign.layer.cornerRadius = 10
        
        self.welcomeSign.layer.borderWidth = 3
        self.welcomeSign.layer.borderColor = UIColor.blackColor().CGColor
        
        self.welcomeSign.clipsToBounds = true
        
        //print(UIFont.familyNames())
        
        //label.textColor =
        
        loadQuizData()
    
    }
    
    func loadQuizData() {
        //Multiple Choice Data
        //let pathMC = NSBundle.mainBundle().pathForResource("MultipleChoice", ofType: "plist")
        //let dictMC = NSDictionary(contentsOfFile: pathMC!)
        //mcArray = dictMC!["Questions"]!.mutableCopy() as? Array
        
        //Single Choice Data
        //let pathSC = NSBundle.mainBundle().pathForResource("SingleChoice", ofType: "plist")
        //let dictSC = NSDictionary(contentsOfFile: pathSC!)
        //scArray = dictMC!["Questions"]!.mutableCopy() as? Array
        
        //Right or Wrong Data
        let pathROW = NSBundle.mainBundle().pathForResource("RightOrWrong", ofType: "plist")
        let dictROW = NSDictionary(contentsOfFile: pathROW!)
        rowArray = dictROW!["Questions"]!.mutableCopy() as? Array
        
        //Imgage Quiz Data
        //let pathIMG = NSBundle.mainBundle().pathForResource("ImageQuiz", ofType: "plist")
        //let dictIMG = NSDictionary(contentsOfFile: pathIMG!)
        //imgArray = dictIMG!["Questions"]!.mutableCopy() as? Array
        
        check()
    }
    
    func check() {
        //print(mcArray)
        //print(scArray)
        //print(imgArray)
        print(rowArray)
    }
}
