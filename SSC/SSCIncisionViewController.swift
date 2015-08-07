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
    var theModel = SSCModel()
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
    
    // MARK: Mange the checkboxes
    func loadCheckboxes()
    {
        var theArray:[Int] = theModel.getArrayValues(0)
        if (theArray[0] == 1)
        {
            introduction.setChecked(true)
        }
        
    }
}