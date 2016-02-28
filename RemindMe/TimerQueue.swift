//
//  NotificationQueue.swift
//  RemindMe
//
//  Created by Tyler Robinson on 2/28/16.
//  Copyright © 2016 Tyler Robinson. All rights reserved.
//

import Foundation
import UIKit


class TimerQueue {
    
    var dict : [Int:NSTimer] = [:]
    
    
    
    public func updateTimer(indx : Int, timer : NSTimer) {
        dict[indx] = timer
    }
    
    public func getTimer(indx : Int) -> NSTimer? {
        if dict[indx] != nil {
            return dict[indx]!
        }
        
        return nil
        
    }
    
    class var sharedInstance : TimerQueue {
        struct Static {
            static let instance : TimerQueue = TimerQueue()
        }
        return Static.instance
    }
}