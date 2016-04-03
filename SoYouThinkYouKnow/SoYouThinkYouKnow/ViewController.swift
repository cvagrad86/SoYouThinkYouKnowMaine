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


class ViewController: UIViewController, EGCDelegate {

    
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
        animator = UIDynamicAnimator(referenceView: self.view)
        gravity = UIGravityBehavior(items: [button, label])
        var collision = UICollisionBehavior(items: [button, label])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator?.addBehavior(collision)
        
        buttonAttachment = UIAttachmentBehavior(item: button,
                                                offsetFromCenter: UIOffsetMake(-5, 0),
                                                attachedToItem: label,
                                                offsetFromCenter: UIOffsetMake(20, 0))
        buttonAttachment?.damping = CGFloat.max
        
        var anchor = UIAttachmentBehavior(item: label,
                                          offsetFromCenter: UIOffsetMake( -1.0 * label.frame.size.width / 2.0, 0),
                                          attachedToAnchor: CGPointMake(label.frame.origin.x, label.frame.origin.y - 20))
        animator?.addBehavior(anchor)
        
        animator?.addBehavior(gravity!)
        animator?.addBehavior(buttonAttachment!)
        
        delay(3.0) {
            self.animator?.removeBehavior(self.buttonAttachment!)
            
            self.delay(0.5) {
                self.animator?.removeBehavior(anchor)
                self.animator?.removeBehavior(collision)
            }
            print("sign is off page now")
        }
        
    }
    
    func delay(seconds: Double, block: () -> ()) {
        let delay = seconds * Double(NSEC_PER_SEC)
        let time: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), block)
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        openingAudio()
        EGC.sharedInstance(self)
        loadQuizData()
    
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
