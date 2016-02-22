//
//  Reminder.swift
//  RemindMe
//
//  Created by Kwame Asante on 2/22/16.
//  Copyright © 2016 Tyler Robinson. All rights reserved.
//

import Foundation
import UIKit

class Reminder {
    
    // MARK: Properties
    
    var name: String
    var date: NSDateFormatter
    
    
    // MARK: Initialization
    
    init?(name: String, date: NSDateFormatter){
        self.name = name
        self.date = date
        if name.isEmpty {
            return nil
        }
    }
    
    
}
