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
    
    
    public func sortByDate() {
        
        let date_formatter = NSDateFormatter()
        date_formatter.dateFormat = "dd-MM-yyyy HH:mm"
        
        
        for var i = 0; i < reminder_dates.count; i++ {
            var temp_date : String! = reminder_dates[i]
            var temp_name : String! = reminder_names[i]
            var temp_descript : String! = reminder_descripts[i]
            
            var j = i - 1
            while (j >= 0 && (date_formatter.dateFromString(temp_date))!.compare((date_formatter.dateFromString(reminder_dates[j]))!) == .OrderedAscending){
            
                reminder_dates[j+1] = reminder_dates[j]
                reminder_descripts[j+1] = reminder_descripts[j]
                reminder_names[j+1] = reminder_names[j]
                
                j = j - 1;
            }
            
            reminder_dates[j+1] = temp_date
            reminder_names[j+1] = temp_name
            reminder_descripts[j+1] = temp_descript
            
            
        }

    }
    

    
    
    public func removeReminder(indx: Int) {
        var new_name_list = [String]()
        var new_descript_list = [String]()
        var new_date_list = [String]()
        
        for var i = 0; i < reminder_dates.count; i++ {
            if i == indx {
                continue
            } else {
                new_name_list.append(reminder_names[i])
                new_date_list.append(reminder_dates[i])
                new_descript_list.append(reminder_descripts[i])
            }
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
