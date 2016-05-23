//
//  Extensions.swift
//  SoYouThinkYouKnow
//
//  Created by Eric Chamberlin on 3/16/16.
//  Copyright © 2016 Eric Chamberlin. All rights reserved.
//

import Foundation

extension Array {
    
    func customSwap<T>(inout a: T, inout b: T) {
        let temp = a
        a = b
        b = temp
    }
    
    mutating func shuffle() {
        if count < 2 {return}
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            customSwap(&self[i], b: &self[j])
        }
        
        
    
}
}