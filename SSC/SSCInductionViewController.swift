//
//  InductionViewController.swift
//  Surgical Safety Checklist
//
//  Created by Jim Hurst on 8/2/15.
//  Copyright (c) 2015 Jim Hurst. All rights reserved.
//

import Foundation
import UIKit

class SSCInductionViewController: UIViewController, UIScrollViewDelegate, UIPopoverPresentationControllerDelegate {

    @IBOutlet var identity: SSCCheckbox!
    @IBOutlet var site: SSCCheckbox!
    @IBOutlet var surgicalProcedure: SSCCheckbox!
    @IBOutlet var consent: SSCCheckbox!
    @IBOutlet var siteMarked: SSCCheckbox!
    @IBOutlet var markingNotApplicable: SSCCheckbox!
    @IBOutlet var safetyCheck: SSCCheckbox!
    @IBOutlet var pulseOx: SSCCheckbox!
    @IBOutlet var knownAllergy: SSCCheckbox!
    @IBOutlet var noKnownAllergy: SSCCheckbox!
    @IBOutlet var noDifficultAirwayRisk: SSCCheckbox!
    @IBOutlet var difficultAirwayRisk: SSCCheckbox!
    @IBOutlet var noBloodLossRisk: SSCCheckbox!
    @IBOutlet var bloodLossRisk: SSCCheckbox!
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
            if (theButton == identity)
            {
              theKey = "identity"
            }
            else if (theButton == site)
            {
                theKey = "site"
            }
            else if (theButton == surgicalProcedure)
            {
                theKey = "procedure"
            }
            else if (theButton == consent)
            {
                theKey = "consent"
            }
            else if (theButton == siteMarked)
            {
                theKey = "marked"
                if (theButton.checked == true)
                {
                    markingNotApplicable.drawNeutral()
                    SSCModel.sharedInstance.setState(0, key: "markingNA", value: 0)
                }
                else
                {
                    markingNotApplicable.drawAlert()
                }
            }
            else if (theButton == markingNotApplicable)
            {
                theKey = "markingNA"
                if ((theButton.checked) == true)
                {
                    siteMarked.drawNeutral()
                    SSCModel.sharedInstance.setState(0, key: "marked", value: 0)
                }
                else
                {
                    siteMarked.drawAlert()
                }
            }
            else if (theButton == safetyCheck)
            {
                theKey = "safetycheck"
            }
            else if (theButton == pulseOx)
            {
                theKey = "pulseox"
            }
            else if (theButton == knownAllergy)
            {
                theKey = "allergy"
                if (theButton.checked == true)
                {
                    noKnownAllergy.drawNeutral()
                    SSCModel.sharedInstance.setState(0, key: "noknownallergy", value: 0)
                }
                else
                {
                    noKnownAllergy.drawAlert()
                }
            }
            else if (theButton == noKnownAllergy)
            {
                theKey = "noknownallergy"
                if (theButton.checked == true)
                {
                    knownAllergy.drawNeutral()
                    SSCModel.sharedInstance.setState(0, key: "allergy", value: 0)
                }
                else
                {
                    knownAllergy.drawAlert()
                }
            }
            else if (theButton == noDifficultAirwayRisk)
            {
                theKey = "noAirwayRisk"
                if (theButton.checked == true)
                {
                    difficultAirwayRisk.drawNeutral()
                    SSCModel.sharedInstance.setState(0, key: "airwayRisk", value: 0)
                }
                else
                {
                    difficultAirwayRisk.drawAlert()
                }
            }
            else if (theButton == difficultAirwayRisk)
            {
                theKey = "airwayRisk"
                if (theButton.checked == true)
                {
                    noDifficultAirwayRisk.drawNeutral()
                    SSCModel.sharedInstance.setState(0, key: "noAirwayRisk", value: 0)
                }
                else
                {
                    noDifficultAirwayRisk.drawAlert()
                }
            }
            else if (theButton == noBloodLossRisk)
            {
                theKey = "noBloodLossRisk"
                if (theButton.checked == true)
                {
                    bloodLossRisk.drawNeutral()
                    SSCModel.sharedInstance.setState(0, key: "bloodlossRisk", value: 0)
                }
                else
                {
                    bloodLossRisk.drawAlert()
                }
            }
            else if (theButton == bloodLossRisk)
            {
                theKey = "bloodlossRisk"
                if (theButton.checked == true)
                {
                    noBloodLossRisk.drawNeutral()
                    SSCModel.sharedInstance.setState(0, key: "noBloodLossRisk", value: 0)
                }
                else
                {
                    noBloodLossRisk.drawAlert()
                }
            }
            SSCModel.sharedInstance.setState(0, key: theKey, value: theVal)
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
            vc.showContent("inductionHelp")
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
        var theArray:[Int] = SSCModel.sharedInstance.getArrayValues(0)
        if (theArray[0] == 1)
        {
            identity.setChecked(true)
        }
        if (theArray[1] == 1)
        {
            site.setChecked(true)
        }
        if (theArray[2] == 1)
        {
            surgicalProcedure.setChecked(true)
        }
        if (theArray[3] == 1)
        {
            consent.setChecked(true)
        }
        if (theArray[4] == 1)
        {
            siteMarked.setChecked(true)
        }
        if (theArray[5] == 1)
        {
            markingNotApplicable.setChecked(true)
        }
        if (theArray[6] == 1)
        {
            safetyCheck.setChecked(true)
        }
        if (theArray[7] == 1)
        {
            pulseOx.setChecked(true)
        }
        if (theArray[8] == 1)
        {
            knownAllergy.setChecked(true)
        }
        if (theArray[9] == 1)
        {
            noKnownAllergy.setChecked(true)
        }
        if (theArray[10] == 1)
        {
            noDifficultAirwayRisk.setChecked(true)
        }
        if (theArray[11] == 1)
        {
            difficultAirwayRisk.setChecked(true)
        }
        if (theArray[12] == 1)
        {
            noBloodLossRisk.setChecked(true)
        }
        if (theArray[13] == 1)
        {
            bloodLossRisk.setChecked(true)
        }
        
    }
}