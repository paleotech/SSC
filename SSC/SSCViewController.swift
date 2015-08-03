//
//  SSCViewController.swift
//  Surgical Safety Checklist
//
//  Created by Jim Hurst on 7/8/15.
//  Copyright (c) 2015 Jim Hurst. All rights reserved.
//

import Foundation
import UIKit

@objc(SSCViewController) class SSCViewController: UITableViewController {
    
    @IBAction func nextButton(sender: UIButton) {
        
    }
    /*
    @IBAction func unwindToList(segue: UIStoryboardSegue) {
        return
    }
    
    @IBAction func unwindToMainMenu(segue: UIStoryboardSegue) {
        self.performSegueWithIdentifier("goToMainMenu", sender: self)
    }
    
*/
    @IBAction func unwindFromB(segue: UIStoryboardSegue)
    {
        self.performSegueWithIdentifier("goToMainMenu", sender: self)
        //segue sourceViewController
        // get whatever data you want to pass back from B
    }
    
    @IBAction func unwindToMain(segue: UIStoryboardSegue) {
        //self.performSegueWithIdentifier("goToMainMenu", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view,
        // typically from a nib.
    }
}