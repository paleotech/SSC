//
//  SSCSignOutViewController.swift
//  Surgical Safety Checklist
//
//  Created by Jim Hurst on 8/2/15.
//  Copyright (c) 2015 Jim Hurst. All rights reserved.
//

import Foundation
import UIKit

class SSCSignOutViewController: UIViewController, UIScrollViewDelegate, UIPopoverPresentationControllerDelegate {
    @IBOutlet var name: SSCCheckbox!
    @IBOutlet var instruments: SSCCheckbox!
    @IBOutlet var specimen: SSCCheckbox!
    @IBOutlet var equipment: SSCCheckbox!
    @IBOutlet var concerns: SSCCheckbox!
    @IBOutlet var theScrollView: UIScrollView!
    @IBOutlet var contentView: UIView!
    
    @IBAction func ButtonPressed( sender: AnyObject? ) {
        if (sender is SSCCheckbox)
        {
            let theButton = sender as! SSCCheckbox
            theButton.checkBoxTapped()
            var theVal: Int = 0
            if (theButton.checked == true)
            {
                theVal = 1
            }
            var theKey: String = ""
            if (theButton == name)
            {
                theKey = "name"
            }
            else if (theButton == instruments)
            {
                theKey = "instruments"
            }
            else if (theButton == specimen)
            {
                theKey = "specimen"
            }
            else if (theButton == equipment)
            {
                theKey = "equipment"
            }
            else if (theButton == concerns)
            {
                theKey = "concerns"
            }
            SSCModel.sharedInstance.setState(2, key: theKey, value: theVal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.theScrollView.delegate = self
        
        let leftConstraint = NSLayoutConstraint(item: self.contentView,
            attribute: NSLayoutAttribute.Leading,
            relatedBy: .Equal,
            toItem:self.view,
            attribute: NSLayoutAttribute.Left,
            multiplier:1.0,
            constant:0);
        self.view.addConstraint(leftConstraint);
        
        let rightConstraint = NSLayoutConstraint(item: self.contentView,
            attribute: NSLayoutAttribute.Trailing,
            relatedBy: .Equal,
            toItem:self.view,
            attribute: NSLayoutAttribute.Right,
            multiplier:1.0,
            constant:0);
        self.view.addConstraint(rightConstraint)
        theScrollView.contentInset = UIEdgeInsetsMake(-48, 0, 0, 0)
    }
    
    override func viewWillAppear(animated:Bool) {
        super.viewWillAppear(animated)
        self.loadCheckboxes()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    // MARK: The following methods support the help popover
    @IBAction func popover(sender: AnyObject) {
        self.performSegueWithIdentifier("showHelp", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        
        if segue.identifier == "showHelp"
        {
            var vc = segue.destinationViewController as! SSCHelpViewController
            vc.showContent("signOutHelp")
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle
    {
        return .None
    }
    
    // MARK: Manage the scrollview
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        scrollView.setContentOffset(CGPointMake(0, scrollView.contentOffset.y), animated:true);
        scrollView.directionalLockEnabled = true;
    }
    
    // MARK: Mange the checkboxes
    func loadCheckboxes()
    {
        var theArray:[Int] = SSCModel.sharedInstance.getArrayValues(2)
        if (theArray[0] == 1)
        {
            name.setChecked(true)
        }
        if (theArray[1] == 1)
        {
            instruments.setChecked(true)
        }
        if (theArray[2] == 1)
        {
            specimen.setChecked(true)
        }
        if (theArray[3] == 1)
        {
            equipment.setChecked(true)
        }
        if (theArray[4] == 1)
        {
            concerns.setChecked(true)
        }
    }
}
