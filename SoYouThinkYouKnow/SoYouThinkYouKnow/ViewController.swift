//
//  ViewController.swift
//  SoYouThinkYouKnow
//
//  Created by Eric Chamberlin on 3/8/16.
//  Copyright © 2016 Eric Chamberlin. All rights reserved.
//


import UIKit
import GameKit
import SystemConfiguration


class ViewController: UIViewController, EGCDelegate {

    @IBOutlet weak var welcomeSign: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.welcomeSign.layer.cornerRadius = 10
        
        self.welcomeSign.layer.borderWidth = 3
        self.welcomeSign.layer.borderColor = UIColor.blackColor().CGColor
        
        self.welcomeSign.clipsToBounds = true
        
        EGC.sharedInstance(self)
        
        loadQuizData()
    
    }
    
    func loadQuizData() {
        //Multiple Choice Data
        let pathMC = NSBundle.mainBundle().pathForResource("MultipleChoice", ofType: "plist")
        let dictMC = NSDictionary(contentsOfFile: pathMC!)
        mcArray = dictMC!["Questions"]!.mutableCopy() as? Array
        
        //Single Choice Data
        //let pathSC = NSBundle.mainBundle().pathForResource("SingleChoice", ofType: "plist")
        //let dictSC = NSDictionary(contentsOfFile: pathSC!)
        //scArray = dictMC!["Questions"]!.mutableCopy() as? Array
        
        //Right or Wrong Data
        let pathROW = NSBundle.mainBundle().pathForResource("RightOrWrong", ofType: "plist")
        let dictROW = NSDictionary(contentsOfFile: pathROW!)
        rowArray = dictROW!["Questions"]!.mutableCopy() as? Array
        
        //Imgage Quiz Data
        let pathIMG = NSBundle.mainBundle().pathForResource("ImageQuiz", ofType: "plist")
        let dictIMG = NSDictionary(contentsOfFile: pathIMG!)
        imgArray = dictIMG!["Questions"]!.mutableCopy() as? Array
       
        //check()
    }
    
    func check() {
        print(imgArray)
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Set new view controller delegate, that's when you change UIViewController
        // If you have several UIViewController just add this in your UIViewControllers for set new Delegate
        EGC.delegate = self
    }
    
    /// ############################################################ ///
    ///        Mark: - Delegate function of EasyGameCenter           ///
    /// ############################################################ ///
    /**
     Listener Player is authentified
     Optional function
     */
    func EGCAuthentified(authentified:Bool) {
        print("Player Authentified = \(authentified)")
    }
    /**
     Listener when Achievements is in cache
     Optional function
     */
    func EGCInCache() {
        // Call when GkAchievement & GKAchievementDescription in cache
    }
    
    /// ############################################################ ///
    ///  Mark: - Delegate function of EasyGameCenter for MultiPlaye  ///
    /// ############################################################ ///
    /**
     Listener When Match Started
     Optional function
     */
    func EGCMatchStarted() {
        print("MatchStarted")
    }
    /**
     Listener When Match Recept Data
     When player send data to all player
     Optional function
     */
        /**
     Listener When Match End
     Optional function
     */
    func EGCMatchEnded() {
        print("MatchEnded")
    }
    /**
     Listener When Match Cancel
     Optional function
     */
    func EGCMatchCancel() {
        print("Match cancel")
    }
   
}
