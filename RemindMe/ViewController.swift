//
//  ViewController.swift
//  RemindMe
//
//  Created by Tyler Robinson on 2/19/16.
//  Copyright (c) 2016 Tyler Robinson. All rights reserved.
//

import UIKit
import Foundation



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


class ViewController: UIViewController, DataEnteredDelegate {
    
    

    // MARK: Properties
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var remind = Remind(name: "yes")
        self.view.addSubview(Remind)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "AddEntry") {
            if let svc = segue.destinationViewController as? ViewControllerB {
                svc.nameToDisplay = remindText.text!
                
                
            }
        }
    }




    
    
//MARK: Actions

    @IBOutlet weak var Add: UIBarButtonItem!

}

