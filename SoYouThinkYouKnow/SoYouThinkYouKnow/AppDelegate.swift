//
//  AppDelegate.swift
//  SoYouThinkYouKnow
//
//  Created by Eric Chamberlin on 3/5/16.
//  Copyright © 2016 Eric Chamberlin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let MapboxAccessToken = "pk.eyJ1IjoiY3ZhZ3JhZDg2IiwiYSI6ImNpa3MzM2UwODA5ZW91eG03c2hkbmlpN2cifQ.yY8BbkFNfrBOJ2KSQ_JCxQ"
        return true
        
        if (UIDevice.currentDevice().userInterfaceIdiom == .Phone) {
            //iPhone
            if Device.IS_3_5_INCHES() {
                //iPhone 4
                bgImage = "opening_graphic_iphone4.png"
            } else if Device.IS_4_INCHES() {
                //iPhone 5
                bgImage = "opening_graphic4_iphone5.png"
            } else if Device.IS_4_7_INCHES() {
                //iPhone 6
                bgImage = "opening_graphic4_iphone6.png"
            } else if Device.IS_5_5_INCHES() {
                //iPhone 6+
                bgImage = "opening_graphic4_iphone6s.png"
            }
        } else {
            //iPad
            bgImage = "opening_graphic4_ipad.png"
        }
        
        return true
    }
    

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

