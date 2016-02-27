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
        
        var insert_index = self.findIndex(date)
        
        self.insertData(insert_index, name : name, description : description, date : date)
        
     //   reminder_names.append(name)
     //   reminder_descripts.append(description)
     //   reminder_dates.append(date)
    }
    
    public func insertData(index : Int, name : String, description : String, date : String) {
        
        var new_name_list = [String]()
        var new_descript_list = [String]()
        var new_date_list = [String]()
        
        var item_added = false
        
        for var i = 0; i <= reminder_dates.count; i++ {
            
            if(index == i) {
                new_name_list.append(name);
                new_date_list.append(date);
                new_descript_list.append(description)
                item_added = true
            } else {
                if item_added {
                    new_name_list.append(reminder_names[i-1])
                    new_descript_list.append(reminder_descripts[i-1])
                    new_date_list.append(reminder_dates[i-1])
                    
                } else {
                    new_name_list.append(reminder_names[i])
                    new_descript_list.append(reminder_descripts[i])
                    new_date_list.append(reminder_dates[i])
                    
                }
            }
            
        }
        
        if(!item_added) {
            new_name_list.append(name);
            new_date_list.append(date);
            new_descript_list.append(description)
        }
        
        
        reminder_names = new_name_list
        reminder_descripts = new_descript_list
        reminder_dates = new_date_list
        
        
        
    }
    
    
    public func findIndex(date : String) -> Int {
        
        let date_formatter = NSDateFormatter()
        date_formatter.dateFormat = "dd-MM-yyyy HH:mm"
        
        let compare_date = date_formatter.dateFromString(date)
        
        var return_index = -1
        
        for var i = 0; i < reminder_dates.count; i++ {
            
            let list_date = date_formatter.dateFromString(reminder_dates[i])
            
            //if the date is less than this date in the list, then put it before that item
            if compare_date!.compare(list_date!) == .OrderedAscending {
                return_index = i
                break
            }
            
        }
        
        if(return_index == -1) {
            return_index = reminder_dates.count
        }
        
        return return_index
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
