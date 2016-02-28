//
//  NotificationQueue.swift
//  RemindMe
//
//  Created by Tyler Robinson on 2/28/16.
//  Copyright © 2016 Tyler Robinson. All rights reserved.
//

import Foundation
import UIKit


class NotificationQueue {
    
    var dict : [Int:UILocalNotification] = [:]
    
    
    
    public func updateNotification(indx : Int, notification : UILocalNotification) {
        dict[indx] = notification
    }
    
    public func getNotification(indx : Int) -> UILocalNotification? {
        if dict[indx] != nil {
            return dict[indx]!
        }
        
        return nil
        
    }
    
    class var sharedInstance : NotificationQueue {
        struct Static {
            static let instance : NotificationQueue = NotificationQueue()
        }
        return Static.instance
    }
}