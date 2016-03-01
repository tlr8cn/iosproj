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
    
    let timer_queue = TimerQueue.sharedInstance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //var remind = Remind(name: "yes")
        //self.view.addSubview(Remind)
        
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: "registerSwipeGesture:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
        
        
        scrollView.contentSize = CGSizeMake(0, 2000);
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(false)
        /*
        for var i = 0; i < reminder_list.reminder_dates.count; i++ {
            var date_formatter = NSDateFormatter()
            date_formatter.dateFormat = "dd-MM-yyyy HH:mm"
            var reminder_date = date_formatter.dateFromString(reminder_list.reminder_dates[i])
            
            var todaysDate:NSDate = NSDate()
            
            
            
            if reminder_date!.compare(todaysDate) == .OrderedAscending {
                var temp = i
                // Create the alert controller
                var alertController = UIAlertController(title: reminder_list.reminder_names[i], message: reminder_list.reminder_descripts[i], preferredStyle: .Alert)
                
                // Create the actions
                var okAction = UIAlertAction(title: "Postpone", style: UIAlertActionStyle.Default) {
                    UIAlertAction in
                    self.postponeReminder(temp, date: reminder_date!.dateByAddingTimeInterval(3600))
                }
                var cancelAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Cancel) {
                    UIAlertAction in
                    self.dismissReminder(temp)
                }
                
                // Add the actions
                alertController.addAction(okAction)
                alertController.addAction(cancelAction)
                
                // Present the controller
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }
*/
    }
    
    func registerSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            if swipeGesture.direction == UISwipeGestureRecognizerDirection.Left {
                for subview in self.scrollView.subviews {
                    if subview is UIButton {
                        var new_button = UIButton(frame: CGRectMake(0, 0, 200, 21))
                        new_button.center = CGPointMake(275, subview.frame.origin.y + 20)
                        new_button.setTitle("Delete", forState: UIControlState.Normal)
                        new_button.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
                        new_button.tag = subview.tag
                        new_button.addTarget(self, action: "deleteReminder:", forControlEvents: UIControlEvents.TouchUpInside)
                        
                        self.scrollView.addSubview(new_button)
                    }
                }
            }
        }
    }
    
    func deleteReminder(sender:UIButton) {
        self.reminder_list.removeReminder(sender.tag)
        self.removeShownReminders()
        self.reminder_list.sortByDate();
        self.showReminders()
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
        
        
        self.removeShownReminders()
        
        
        if input_array.count < 4 {
            self.reminder_list.addReminder(input_array[0], description: input_array[1], date: input_array[2])
            
        } else {
            var list_indx : Int! = Int(input_array[3])
            self.reminder_list.reminder_names[list_indx] = input_array[0]
            self.reminder_list.reminder_descripts[list_indx] = input_array[1]
            self.reminder_list.reminder_dates[list_indx] = input_array[2]
            
            self.reminder_list.sortByDate();
            
        }
        
        self.showReminders()

    }


    func removeShownReminders() {
        for subview in scrollView.subviews {
            if subview is UILabel || subview is UIButton{
                subview.removeFromSuperview()
            }
            
        }
    }
    
    
    func showInfo(sender: UIButton!) {
        
        tapped_button_tag = sender.tag
        performSegueWithIdentifier("EditEntry", sender: nil)
        
        
    }
    
    func showReminders() {
        
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
            
           // print("tag: " + String(name_button.tag))
            
            
            var date_formatter = NSDateFormatter()
            date_formatter.dateFormat = "dd-MM-yyyy HH:mm"
            var reminder_date = date_formatter.dateFromString(reminder_list.reminder_dates[i])
            
            var todaysDate:NSDate = NSDate()
            
            let prev_timer : NSTimer? = timer_queue.getTimer(name_button.tag)
            
            if prev_timer != nil {
                prev_timer?.invalidate()
            }
            
            var interval = NSCalendar.currentCalendar().components(NSCalendarUnit.Second, fromDate: todaysDate, toDate: reminder_date!, options: []).second
            
            var timer = NSTimer.scheduledTimerWithTimeInterval(Double(interval), target: self, selector: "createAlert:", userInfo: name_button.tag, repeats: false)
            
            timer_queue.updateTimer(name_button.tag, timer: timer)
            
            /*
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
            */
            
            scrollView.addSubview(name_button)
            
            scrollView.addSubview(descr_label)
            scrollView.addSubview(date_label)
            scrollView.addSubview(separator)
            
            counter += 65.0
        }
    }
    
    func createAlert(timer: NSTimer) {
        
        let indx : Int = timer.userInfo as! Int
        
        print("index: " + String(indx))
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        var reminder_date = dateFormatter.dateFromString(reminder_list.reminder_dates[indx])
        
        var alertController = UIAlertController(title: reminder_list.reminder_names[indx], message: reminder_list.reminder_descripts[indx], preferredStyle: .Alert)
        
        // Create the actions
        var okAction = UIAlertAction(title: "Postpone", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            self.postponeReminder(indx, date: reminder_date!.dateByAddingTimeInterval(3600))
        }
        var cancelAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
            self.dismissReminder(indx)
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    

    func dismissReminder(indx: Int) {
        self.reminder_list.removeReminder(indx)
        self.removeShownReminders()
        self.reminder_list.sortByDate();
        self.showReminders()
    }
    
    func postponeReminder(indx: Int, date : NSDate) {
        
        var date_formatter = NSDateFormatter()
        date_formatter.dateFormat = "dd-MM-yyyy HH:mm"
        var new_reminder_date = date_formatter.stringFromDate(date)
        
        reminder_list.reminder_dates[indx] = new_reminder_date
        
        self.removeShownReminders()
        self.reminder_list.sortByDate();
        self.showReminders()
   
    }
    
    
//MARK: Actions

    @IBOutlet weak var Add: UIBarButtonItem!

}

