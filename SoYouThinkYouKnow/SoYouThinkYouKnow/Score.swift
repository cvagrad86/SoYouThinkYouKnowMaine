//
//  Score.swift
//  SoYouThinkYouKnow
//
//  Created by Eric Chamberlin on 3/10/16.
//  Copyright © 2016 Eric Chamberlin. All rights reserved.
//




import UIKit
import Foundation
import GameKit

/*
struct GameScore {
    var currentScore: NSInteger
    var overallScore: NSInteger
    var tfscore: NSInteger
    var mcscore: NSInteger
    var photoscore: NSInteger
    var mapscore: NSInteger
    
}
//let scores = GameScore(currentScore: 0, overallScore: 0, tfscore: 0, mcscore: 0, photoscore: 0, mapscore: 0)
//var tfArray: Array<[Int:AnyObject]>?
 */

class Scoring {
    
    static let sharedGameData = Scoring()
    
    var tfscore: Int = 0
    var mcscore: Int = 0
    var mapsscore: Int = 0
    var photoscore: Int = 0
    var overallscore: Int = 0
    var bonusPoints: Int = 0
    
    
    init () {
    
        overallscore = (tfscore + mcscore + mapsscore + photoscore)
        
    }
}












