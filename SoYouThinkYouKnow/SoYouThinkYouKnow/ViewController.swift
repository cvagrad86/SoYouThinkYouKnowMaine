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
import AVKit
import AVFoundation
import GoogleMobileAds

let endOfRoundOne = "com.ericchamberlin.SoYouThinkYouKnow.endOfRoundOneKey"
let endOfRoundTwo = "com.ericchamberlin.SoYouThinkYouKnow.endOfRoundTwoKey"
let endOfRoundThree = "com.ericchamberlin.SoYouThinkYouKnow.endOfRoundThreeKey"
let endOfRoundFour = "com.ericchamberlin.SoYouThinkYouKnow.endOfRoundFourKey"

class ViewController: UIViewController, EGCDelegate {

    var score = 0
    @IBOutlet weak var welcomeSign: UIButton!
    @IBOutlet weak var trueFalseSign: UIButton!
    @IBOutlet weak var maineMapsSign: UIButton!
    @IBOutlet weak var multChoiceSign: UIButton!
    @IBOutlet weak var nameThatPhoto: UIButton!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    
    let viewTransitionDelegate = TransitionDelegate()
    
   /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationViewController = segue.destinationViewController as! WelcomeViewController
        destinationViewController.transitioningDelegate = viewTransitionDelegate
        destinationViewController.modalPresentationStyle = .Custom
        audioPlayer!.stop()
    }
 */
 
    var audioPlayer: AVAudioPlayer?
    
    var animator: UIDynamicAnimator?
    var gravity: UIGravityBehavior?
    var buttonAttachment: UIAttachmentBehavior?
    
    @IBAction func buttonTapped(sender: AnyObject) {
        
    }
    
    func delay(seconds: Double, block: () -> ()) {
        let delay = seconds * Double(NSEC_PER_SEC)
        let time: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), block)
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //maineMapsSign.enabled = false
        //nameThatPhoto.enabled = false
        //trueFalseSign.enabled = false
        //multChoiceSign.enabled = false
        //welcomeSign.enabled = true
    
        openingAudio()
        EGC.sharedInstance(self)
        loadQuizData()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.goToMultChoice(_:)), name: "endOfRoundOne", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.goToPhotos(_:)), name: "endOfRoundTwo", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.goToMaps(_:)), name: "endOfRoundThree", object: nil)
        
         print("Google Mobile Ads SDK version: " + GADRequest.sdkVersion())
    }
    
    override func viewDidDisappear(animated: Bool) {
        audioPlayer?.stop()
        
    }
    
    func openingAudio () {
        do {
            audioPlayer =  try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("opening_sound3", ofType: "mp3")!))
            audioPlayer!.play()
            
        } catch {
            print("Error")
        }
    }
    
    func goToMultChoice (notification: NSNotification) {
        //hide the welcome and TF sign - make other 2 locked
        maineMapsSign.enabled = false
        nameThatPhoto.enabled = false
        multChoiceSign.enabled = true
        welcomeSign.hidden = true
        trueFalseSign.hidden = true
        audioPlayer?.stop()
    }
    
    func goToPhotos (notification: NSNotification) {
        //hide the mc sign - keep maps locked
        nameThatPhoto.enabled = true
        multChoiceSign.hidden = true
        welcomeSign.hidden = true
        trueFalseSign.hidden = true
        maineMapsSign.enabled = false
        audioPlayer?.stop()
    }
    
    func goToMaps(notification: NSNotification) {
        //go to maps
        nameThatPhoto.hidden = true
        multChoiceSign.hidden = true
        welcomeSign.hidden = true
        trueFalseSign.hidden = true
        maineMapsSign.enabled = true
        audioPlayer?.stop()
        
    }
    
    
    func loadQuizData() {
        //Multiple Choice Data
        let pathMC = NSBundle.mainBundle().pathForResource("MultipleChoice", ofType: "plist")
        let dictMC = NSDictionary(contentsOfFile: pathMC!)
        mcArray = dictMC!["Questions"]!.mutableCopy() as? Array
        
        
        //Right or Wrong Data
        let pathROW = NSBundle.mainBundle().pathForResource("RightOrWrong", ofType: "plist")
        let dictROW = NSDictionary(contentsOfFile: pathROW!)
        rowArray = dictROW!["Questions"]!.mutableCopy() as? Array
        
        //Imgage Quiz Data
        let pathIMG = NSBundle.mainBundle().pathForResource("ImageQuiz", ofType: "plist")
        let dictIMG = NSDictionary(contentsOfFile: pathIMG!)
        imgArray = dictIMG!["Questions"]!.mutableCopy() as? Array
       /*
        let  HighscoreDefault = NSUserDefaults.standardUserDefaults()
        let TFScore = NSUserDefaults.standardUserDefaults()
        let MCScore = NSUserDefaults.standardUserDefaults()
        let PhotosScore = NSUserDefaults.standardUserDefaults()
        let MapsScore = NSUserDefaults.standardUserDefaults()
        
        var TFtotal = TFScore.valueForKey("tfscore") as! NSInteger
        var MCTotal = MCScore.valueForKey("mcscore") as! NSInteger
        var MapsTotal = MapsScore.valueForKey("mapscore") as! NSInteger
        var PhotoTotal = PhotosScore.valueForKey("photoscore") as! NSInteger

        //TFtotal = score
        //MCTotal = score
//MapsTotal = score
        //PhotoTotal = score
 */
        
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
