//
//  GameCenterViewController.swift
//  SoYouThinkYouKnow
//
//  Created by Eric Chamberlin on 5/18/16.
//  Copyright © 2016 Eric Chamberlin. All rights reserved.
//

import UIKit
import GameKit
import GameController

class GameCenterViewController:  UIViewController, GKGameCenterControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    @IBAction func gameCenter(sender: AnyObject) {
        saveHighscore(Scoring.sharedGameData.overallscore)
        showLeaderBoard()
    }
    
    func authPlayer(){
        let localPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {
            (view, error) in
            
            if view != nil {
                
                self.presentViewController(view!, animated: true, completion: nil)
                
            }
            else {
                
                print(GKLocalPlayer.localPlayer().authenticated)
                
            }
            
            
        }
    }
    
    
    func saveHighscore(number : Int){
        
        if GKLocalPlayer.localPlayer().authenticated {
            
            let scoreReporter = GKScore(leaderboardIdentifier: "TopMainah")
            
            scoreReporter.value = Int64(number)
            
            let scoreArray : [GKScore] = [scoreReporter]
            
            GKScore.reportScores(scoreArray, withCompletionHandler: nil)
            
        }
        
        
    }
    
    func showLeaderBoard(){
        let viewController = self.view.window?.rootViewController
        let gcvc = GKGameCenterViewController()
        
        gcvc.gameCenterDelegate = self
        
        dispatch_async(dispatch_get_main_queue(), {() -> Void in
            self.presentViewController(gcvc, animated: true, completion: { _ in })
        })
        
        viewController?.presentViewController(gcvc, animated: true, completion: nil)
    }
    
    
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
        
    }


}
