//
//  ReminderTableViewController.swift
//  RemindMe
//
//  Created by Kwame Asante on 2/22/16.
//  Copyright © 2016 Tyler Robinson. All rights reserved.
//

import UIKit

class ReminderTableViewController: UITableViewController {
    
    // Mark: Properties
    @IBOutlet weak var reminder: UILabel!
    var entry:String!
    
    var reminders = [Reminder]()
    
    func addReminder(name: String) {
        let remind = Reminder(name: name)!
        reminders += [remind]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelPassedData.text = entry
        addReminder(entry)
    }

}
