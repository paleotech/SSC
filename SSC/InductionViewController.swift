//
//  InductionViewController.swift
//  Surgical Safety Checklist
//
//  Created by Jim Hurst on 8/2/15.
//  Copyright (c) 2015 Jim Hurst. All rights reserved.
//

import Foundation
import UIKit

class InductionViewController: UIViewController, UIScrollViewDelegate, UIPopoverPresentationControllerDelegate {

    @IBOutlet var identity: SSCCheckbox!
    @IBOutlet var site: SSCCheckbox!
    @IBOutlet var surgicalProcedure: SSCCheckbox!
    @IBOutlet var consent: SSCCheckbox!
    @IBOutlet var siteMarked: SSCCheckbox!
    @IBOutlet var markingNotApplicable: SSCCheckbox!
    @IBOutlet var puiseOx: SSCCheckbox!
    @IBOutlet var knownAllergy: SSCCheckbox!
    @IBOutlet var noKnownAllergy: SSCCheckbox!
    @IBOutlet var noDifficultAirwayRisk: SSCCheckbox!
    @IBOutlet var difficultAirwayRisk: SSCCheckbox!
    @IBOutlet var noBloodLossRisk: SSCCheckbox!
    @IBOutlet var bloodLossRisk: SSCCheckbox!
    @IBOutlet var contentView: UIView!
    @IBOutlet var theScrollView: UIScrollView!

    
    func updateDisplay(textField: AnyObject)
    {

    }
    
    @IBAction func ButtonPressed( sender: AnyObject? ) {
        if (sender is SSCCheckbox)
        {
            let theButton = sender as! SSCCheckbox
            theButton.checkBoxTapped()
        }
        self.updateDisplay(sender!)
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
            //vc = segue.destinationViewController as! HelpViewController
            //vc.showContent("basic")
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
}