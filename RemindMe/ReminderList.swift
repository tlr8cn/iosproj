//
//  ReminderList.swift
//  RemindMe
//
//  Created by Tyler Robinson on 2/22/16.
//  Copyright (c) 2016 Tyler Robinson. All rights reserved.
//

import Foundation

class ReminderList {
    
    public var reminder_names = [String]()
    public var reminder_descripts = [String]()
    public var reminder_dates = [String]()
    
    
    public func addReminder(name : String, description : String, date : String) {
        reminder_names.append(name)
        reminder_descripts.append(description)
        reminder_dates.append(date)
    }
    
//    public func getList() {
 //       return reminders
 //   }
    
    class var sharedInstance : ReminderList {
        struct Static {
            static let instance : ReminderList = ReminderList()
        }
        return Static.instance
    }
    
}
