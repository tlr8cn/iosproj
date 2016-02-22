//
//  setup.swift
//  RemindMe
//
//  Created by Kwame Asante on 2/22/16.
//  Copyright © 2016 Tyler Robinson. All rights reserved.
//

import Foundation


class ViewController: UIViewController {


override func viewDidLoad(){
    super.viewDidLoad()
}

override func prepareForSegue(segue: UIStroyboardSegue!, sender: AnyObject!){
    if(segue.identifier == "AddEntry"){
        var entry = segue!.destinationViewController as ReminderTableViewCell;
        entry.toPass = textfield.text
    }
}

}