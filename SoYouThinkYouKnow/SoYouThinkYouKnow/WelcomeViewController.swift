//
//  WelcomeViewController.swift
//  SoYouThinkYouKnow
//
//  Created by Eric Chamberlin on 3/30/16.
//  Copyright © 2016 Eric Chamberlin. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController, BWWalkthroughViewControllerDelegate {
    
    var needWalkthrough:Bool = true
    var walkthrough:BWWalkthroughViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if needWalkthrough {
            self.presentWalkthrough()
        }
    }
    
    @IBAction func presentWalkthrough(){
        
        let stb = UIStoryboard(name: "Main", bundle: nil)
        walkthrough = stb.instantiateViewControllerWithIdentifier("container") as! BWWalkthroughViewController
        
        let page_two = stb.instantiateViewControllerWithIdentifier("page_2_tf")
        let page_three = stb.instantiateViewControllerWithIdentifier("page_3_mc")
        let page_four = stb.instantiateViewControllerWithIdentifier("page_4_photos")
        let page_five = stb.instantiateViewControllerWithIdentifier("page_5_maps")
        let page_six = stb.instantiateViewControllerWithIdentifier("page_6_scoring")
        
        // Attach the pages to the master
        walkthrough.delegate = self
       
        walkthrough.addViewController(page_two)
        print("page two of walkthrough")
        walkthrough.addViewController(page_three)
        walkthrough.addViewController(page_four)
        walkthrough.addViewController(page_five)
        walkthrough.addViewController(page_six)
        
        self.presentViewController(walkthrough, animated: true) {
            ()->() in
            self.needWalkthrough = false
        }
    }
}


extension WelcomeViewController{
    
    func walkthroughCloseButtonPressed() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func walkthroughPageDidChange(pageNumber: Int) {
        if (self.walkthrough.numberOfPages - 1) == pageNumber{
            self.walkthrough.closeButton?.hidden = false
        }else{
            self.walkthrough.closeButton?.hidden = true
        }
    }
    
}
