//
//  EditViewController.swift
//  RemindMe
//
//  Created by Tyler Robinson on 2/25/16.
//  Copyright © 2016 Tyler Robinson. All rights reserved.
//

import Foundation
import UIKit



class EditViewController: UIViewController{
    
    @IBOutlet weak var reminder_name: UITextField!
    
    @IBOutlet weak var reminder_description: UITextField!
    
    @IBOutlet weak var date_picker: UIDatePicker!
    

    let reminder_list = ReminderList.sharedInstance
    
    var button_tag : Int!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        reminder_name.text = reminder_list.reminder_names[button_tag]
        reminder_description.text = reminder_list.reminder_descripts[button_tag]
        
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        date_picker.setDate(dateFormatter.dateFromString(reminder_list.reminder_dates[button_tag])!, animated: false)
        
        
    }
    
    
    
    
}