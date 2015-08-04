//
//  SSCCheckbox.swift
//  SSC
//
//  Created by Jim Hurst on 8/4/15.
//  Copyright (c) 2015 Dry RIdge Software. All rights reserved.
//

import Foundation
import UIKit

class SSCCheckbox: UIButton
{
    
    var checked: Bool?
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
    }
    
    func setup(frame: CGRect)
    {
        //self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        let image = UIImage(named: "CheckboxAlert") as UIImage!
        self.setImage(image, forState: .Normal)
        self.addTarget(self, action: "checkboxTapped:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func setChecked(isChecked: Bool)
    {
        checked = isChecked;
        if ((checked) != nil)
        {
            let image = UIImage(named: "CheckboxChecked") as UIImage!
            self.setImage(image, forState: .Normal)
        }
        else
        {
            let image = UIImage(named: "CheckboxUnchecked") as UIImage!
            self.setImage(image, forState: .Normal)
        }
    }
    
    func drawAlert()
    {
        let image = UIImage(named: "CheckboxAlert") as UIImage!
        self.setImage(image, forState: .Normal)
    }
    
    
    func checkBoxTapped()
    {
        if checked == true
        {
            checked = false;
        }
        else
        {
            checked = true;
        }
        
        if checked == true
        {
            self.setImage(UIImage(named: "CheckboxChecked"), forState: .Normal)
            
        }
        else
        {
            self.setImage(UIImage(named: "CheckboxUnchecked"), forState: .Normal)
        }
     }
}