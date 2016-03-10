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
        
              
        
    }
}
