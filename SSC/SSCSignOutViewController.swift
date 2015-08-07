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
