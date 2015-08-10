//
//  SSCIncisionViewController.swift
//  Surgical Safety Checklist
//
//  Created by Jim Hurst on 8/2/15.
//  Copyright (c) 2015 Jim Hurst. All rights reserved.
//

import Foundation
import UIKit

class SSCIncisionViewController: UIViewController, UIScrollViewDelegate, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet var introduction: SSCCheckbox!
    @IBOutlet var patient: SSCCheckbox!
    @IBOutlet var site: SSCCheckbox!
    @IBOutlet var surgicalProcedure: SSCCheckbox!
    @IBOutlet var surgeonReview: SSCCheckbox!
    @IBOutlet var anesthesiaReview: SSCCheckbox!
    @IBOutlet var nursingReview: SSCCheckbox!
    @IBOutlet var antibioticGiven: SSCCheckbox!
    @IBOutlet var antibioticNA: SSCCheckbox!
    @IBOutlet var imagingDisplayed: SSCCheckbox!
    @IBOutlet var imagingNA: SSCCheckbox!
    @IBOutlet var contentView: UIView!
    @IBOutlet var theScrollView: UIScrollView!
    
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
            if (theButton == introduction)
            {
                theKey = "intro"
            }
            else if (theButton == patient)
            {
                theKey = "patient"
            }
            else if (theButton == site)
            {
                theKey = "site"
            }
            else if (theButton == surgicalProcedure)
            {
                theKey = "procedure"
            }
            else if (theButton == surgeonReview)
            {
                theKey = "surgeonreview"
            }
            else if (theButton == anesthesiaReview)
            {
                theKey = "anesthesiareview"
            }
            else if (theButton == nursingReview)
            {
                theKey = "nursingreview"
            }
            else if (theButton == antibioticGiven)
            {
                theKey = "antibiotics"
                if (theButton.checked == true)
                {
                    antibioticNA.drawNeutral()
                    SSCModel.sharedInstance.setState(1, key: "antibioticsNA", value: 0)
                }
                else
                {
                    antibioticNA.drawAlert()
                }
            }
            else if (theButton == antibioticNA)
            {
                theKey = "antibioticsNA"
                if (theButton.checked == true)
                {
                    antibioticGiven.drawNeutral()
                    SSCModel.sharedInstance.setState(1, key: "antibiotics", value: 0)
                }
                else
                {
                    antibioticGiven.drawAlert()
                }
            }
            else if (theButton == imagingDisplayed)
            {
                theKey = "imaging"
                if (theButton.checked == true)
                {
                    imagingNA.drawNeutral()
                    SSCModel.sharedInstance.setState(1, key: "imagingNA", value: 0)
                }
                else
                {
                    imagingNA.drawAlert()
                }
            }
            else if (theButton == imagingNA)
            {
                theKey = "imagingNA"
                if (theButton.checked == true)
                {
                    imagingDisplayed.drawNeutral()
                    SSCModel.sharedInstance.setState(1, key: "imaging", value: 0)
                }
                else
                {
                    imagingDisplayed.drawAlert()
                }
            }
            SSCModel.sharedInstance.setState(1, key: theKey, value: theVal)
        }
    }
    
    @IBAction func HelpPressed( sender: AnyObject? ) {

    }
    
    @IBAction func ClearPressed( sender: AnyObject? ) {

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
            vc.showContent("incisionHelp")
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
        var theArray:[Int] = SSCModel.sharedInstance.getArrayValues(1)
        if (theArray[0] == 1)
        {
            introduction.setChecked(true)
        }
        if (theArray[1] == 1)
        {
            patient.setChecked(true)
        }
        if (theArray[2] == 1)
        {
            site.setChecked(true)
        }
        if (theArray[3] == 1)
        {
            surgicalProcedure.setChecked(true)
        }
        if (theArray[4] == 1)
        {
            surgeonReview.setChecked(true)
        }
        if (theArray[5] == 1)
        {
            anesthesiaReview.setChecked(true)
        }
        if (theArray[6] == 1)
        {
            nursingReview.setChecked(true)
        }
        if (theArray[7] == 1)
        {
            antibioticGiven.setChecked(true)
        }
        if (theArray[8] == 1)
        {
            antibioticNA.setChecked(true)
        }
        if (theArray[9] == 1)
        {
            imagingDisplayed.setChecked(true)
        }
        if (theArray[10] == 1)
        {
            imagingNA.setChecked(true)
        }
    }
}