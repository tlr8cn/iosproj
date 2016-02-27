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
    
    weak var delegate: DataEnteredDelegate? = nil
    
    let reminder_list = ReminderList.sharedInstance
    
    var button_tag : Int!
    
    @IBOutlet weak var reminder_name: UITextField!
    
    @IBOutlet weak var reminder_description: UITextField!
    
    @IBOutlet weak var date_picker: UIDatePicker!
    
    
    @IBAction func doneEditingInfo(sender: AnyObject) {
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        var strDate = dateFormatter.stringFromDate(date_picker.date)
        
        var data_str = reminder_name.text! + "&&&" + reminder_description.text! + "&&&" + strDate
        data_str = data_str + "&&&" + String(button_tag)
        
        delegate?.userDidEnterInformation(data_str)        
        /*
        
        self.reminder_list.reminder_names[button_tag] = reminder_name.text!
        self.reminder_list.reminder_descripts[button_tag] = reminder_description.text!
        self.reminder_list.reminder_dates[button_tag] = strDate
        
    */
        
        
        //back to previous view controller
        self.navigationController?.popViewControllerAnimated(true)
        
    }

    

    override func viewDidLoad(){
        super.viewDidLoad()
        
        reminder_name.text = reminder_list.reminder_names[button_tag]
        reminder_description.text = reminder_list.reminder_descripts[button_tag]
        
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        date_picker.setDate(dateFormatter.dateFromString(reminder_list.reminder_dates[button_tag])!, animated: false)
        
        
    }
    
    
    
    
}