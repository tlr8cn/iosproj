//
//  ViewController.swift
//  RemindMe
//
//  Created by Tyler Robinson on 2/19/16.
//  Copyright (c) 2016 Tyler Robinson. All rights reserved.
//

import UIKit
import Foundation


/*
class Remind {
    
    // MARK: Properties
    
    var name: String
    //var date: NSDateFormatter
    
    
    // MARK: Initialization
    
    init?(name: String){
        self.name = name
        //self.date = date
        if name.isEmpty {
            return nil
        }
    }
    
}
*/





class ViewController: UIViewController, DataEnteredDelegate {
    
    

    // MARK: Properties
    
    let reminder_list = ReminderList.sharedInstance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //var remind = Remind(name: "yes")
        //self.view.addSubview(Remind)


        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "AddEntry") {
            let svc = segue.destinationViewController as! ViewControllerB
            svc.delegate = self
        }
    }
    
    func userDidEnterInformation(info: String) {
        //place label info here potentially
        
        let input_array = info.componentsSeparatedByString("&&&")
        
        self.reminder_list.addReminder(input_array[0], description: input_array[1], date: input_array[2])
        
        
        for label in self.view.subviews {
            if label is UILabel {
                label.removeFromSuperview()
            }
            
        }
        
        
        var counter = 80.0
        
        for var i = 0; i < reminder_list.reminder_names.count; ++i {
            
            var name_label = UILabel(frame: CGRectMake(0, 0, 200, 21))
            var descr_label = UILabel(frame: CGRectMake(0, 0, 200, 21))
            var date_label = UILabel(frame: CGRectMake(0, 0, 200, 21))
            var separator = UILabel(frame: CGRectMake(0, 0, self.view.frame.size.width, 21))
            
            name_label.center = CGPointMake(160, CGFloat(counter))
            descr_label.center = CGPointMake(160, CGFloat(counter + 15))
            date_label.center = CGPointMake(160, CGFloat(counter + 30))
            separator.center = CGPointMake(160, CGFloat(counter + 45))
            
            name_label.textAlignment = NSTextAlignment.Center
            descr_label.textAlignment = NSTextAlignment.Center
            date_label.textAlignment = NSTextAlignment.Center
            separator.textAlignment = NSTextAlignment.Center
            
            name_label.text = reminder_list.reminder_names[i]
            descr_label.text = reminder_list.reminder_descripts[i]
            date_label.text = reminder_list.reminder_dates[i]
            separator.text = "________________________________"
            
            descr_label.textColor = UIColor.blackColor().colorWithAlphaComponent(0.75)
            descr_label.font = descr_label.font.fontWithSize(11)
            
            date_label.textColor = UIColor.blackColor().colorWithAlphaComponent(0.60)
            date_label.font = date_label.font.fontWithSize(9)
            
            
            separator.textColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
            
            self.view.addSubview(name_label)
            self.view.addSubview(descr_label)
            self.view.addSubview(date_label)
            self.view.addSubview(separator)
            
            counter += 65.0
        }
        /*
        for reminder in self.reminder_list.reminders {
            var label = UILabel(frame: CGRectMake(0, 0, 200, 21))
            label.center = CGPointMake(160, CGFloat(counter))
            label.textAlignment = NSTextAlignment.Center
            label.text = reminder
            self.view.addSubview(label)
            
            counter += 40.0
        }
        */
    }




    
    
//MARK: Actions

    @IBOutlet weak var Add: UIBarButtonItem!

}

