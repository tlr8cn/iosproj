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
    
    var tapped_button_tag = -1
    
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    let reminder_list = ReminderList.sharedInstance
    
    let notification_queue = NotificationQueue.sharedInstance
    
    
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
        
        } else if(segue.identifier == "EditEntry") {
            let svc = segue.destinationViewController as! EditViewController
            svc.delegate = self
            svc.button_tag = tapped_button_tag
        }
        

    }
    
    func userDidEnterInformation(info: String) {
        
        //if a new reminder was added, we want to add it to the list
        //otherwise, we want to edit an existing reminder in the list
        
        
        let input_array = info.componentsSeparatedByString("&&&")
        
        
        for subview in scrollView.subviews {
            if subview is UILabel || subview is UIButton{
                subview.removeFromSuperview()
            }
            
        }
        
        
        if input_array.count < 4 {
            self.reminder_list.addReminder(input_array[0], description: input_array[1], date: input_array[2])
            
        } else {
            var list_indx : Int! = Int(input_array[3])
            self.reminder_list.reminder_names[list_indx] = input_array[0]
            self.reminder_list.reminder_descripts[list_indx] = input_array[1]
            self.reminder_list.reminder_dates[list_indx] = input_array[2]
            
            self.reminder_list.sortByDate();
            
        }
        
        
        
        
        
        var counter = 15.0
        
        for var i = 0; i < reminder_list.reminder_names.count; ++i {
            
            var name_button = UIButton(frame: CGRectMake(0, 0, 200, 21))
            var descr_label = UILabel(frame: CGRectMake(0, 0, 200, 21))
            var date_label = UILabel(frame: CGRectMake(0, 0, 200, 21))
            var separator = UILabel(frame: CGRectMake(0, 0, self.view.frame.size.width, 21))
            
            
            
            name_button.center = CGPointMake(160, CGFloat(counter))
            descr_label.center = CGPointMake(160, CGFloat(counter + 15))
            date_label.center = CGPointMake(160, CGFloat(counter + 30))
            separator.center = CGPointMake(160, CGFloat(counter + 45))
            

            descr_label.textAlignment = NSTextAlignment.Center
            date_label.textAlignment = NSTextAlignment.Center
            separator.textAlignment = NSTextAlignment.Center
            
            name_button.setTitle(reminder_list.reminder_names[i], forState: UIControlState.Normal)
            name_button.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
            descr_label.text = reminder_list.reminder_descripts[i]
            date_label.text = reminder_list.reminder_dates[i]
            separator.text = "________________________________"
            
            descr_label.textColor = UIColor.blackColor().colorWithAlphaComponent(0.75)
            descr_label.font = descr_label.font.fontWithSize(11)
            
            date_label.textColor = UIColor.blackColor().colorWithAlphaComponent(0.60)
            date_label.font = date_label.font.fontWithSize(9)
            
            
            name_button.addTarget(self, action: "showInfo:", forControlEvents: UIControlEvents.TouchUpInside)
            
            separator.textColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
            
            
            name_button.tag = i
            
            
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
            var date = dateFormatter.dateFromString(reminder_list.reminder_dates[i])
            
            let notification = UILocalNotification()
            notification.fireDate = date
            notification.alertBody = "REMINDER: " + reminder_list.reminder_names[i]
            notification.alertAction = "Got it!"
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
            
            let prev_notification : UILocalNotification? = notification_queue.getNotification(name_button.tag)
           
            if prev_notification != nil {
                UIApplication.sharedApplication().cancelLocalNotification(prev_notification!)
            }
            
            notification_queue.updateNotification(name_button.tag, notification: notification)
            
            scrollView.addSubview(name_button)
            
            scrollView.addSubview(descr_label)
            scrollView.addSubview(date_label)
            scrollView.addSubview(separator)
            
            counter += 65.0
        }

    }


    func showInfo(sender: UIButton!) {
        
        tapped_button_tag = sender.tag
        performSegueWithIdentifier("EditEntry", sender: nil)
        
        
    }


    
    
//MARK: Actions

    @IBOutlet weak var Add: UIBarButtonItem!

}

