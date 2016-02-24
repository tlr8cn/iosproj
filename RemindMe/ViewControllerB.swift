//
//  setup.swift
//  RemindMe
//
//  Created by Kwame Asante on 2/22/16.
//  Copyright © 2016 Tyler Robinson. All rights reserved.
//

import Foundation
import UIKit

protocol DataEnteredDelegate: class {
    func userDidEnterInformation(info: String)
}


class ViewControllerB: UIViewController {
// Mark: Properties
    
    weak var delegate: DataEnteredDelegate? = nil

    @IBOutlet weak var remindText: UITextField!
    
    @IBOutlet weak var desc: UITextField!
    
    @IBOutlet weak var date: UIDatePicker!
    
    
    @IBAction func sendInfoButton(sender: AnyObject) {
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyy HH:mm"
        var strDate = dateFormatter.stringFromDate(date.date)
        
        var data_str = remindText.text! + "&&&" + desc.text! + "&&&" + strDate
        
        delegate?.userDidEnterInformation(data_str)

        
        //back to previous view controller
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    
override func viewDidLoad(){
    super.viewDidLoad()
}

    
    
    
    
}