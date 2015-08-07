//
//  SSCViewController.swift
//  Surgical Safety Checklist
//
//  Created by Jim Hurst on 7/8/15.
//  Copyright (c) 2015 Jim Hurst. All rights reserved.
//

import Foundation
import UIKit

@objc(SSCViewController) class SSCViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var theTableView: UITableView!
    
    var items: [String] = ["Before Induction", "Before Incision", "Before Sign Out"]
    var theModel = SSCModel()
    
    // MARK: view life cycle
    @IBAction func unwindToThisViewController(segue: UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.theTableView.registerClass(SSCTableViewCell.self, forCellReuseIdentifier: "SSCCell")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.displayTiles()
    }
    
    // MARK: table view functions
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("SSCCell", forIndexPath: indexPath) as! SSCTableViewCell
        
        let theString = self.items[indexPath.row] as NSString
        cell.theLabel.text = theString as String!
        var imageSize = CGSizeMake(135,15)
        let tileSize = CGSizeMake(15,15)
        let greenImage = UIImage(named: "GreenTile") as UIImage!
        let redImage = UIImage(named: "RedTile") as UIImage!
        var theArray = theModel.getState(indexPath.row)
        var imageRect = CGRectMake(0.0, 0.0, imageSize.width, imageSize.height)
        UIGraphicsBeginImageContext(imageSize);
        // Start with Induction
        var theEnd = 9
        if (indexPath.row == 2)
        {
            theEnd = 5
        }
        for var i = 0; i < theEnd; i++
        {
            var theX = CGFloat(i) * tileSize.width
            var thePoint: CGPoint = CGPointMake(theX, 0)
            var modelString = theArray[i]
            if (modelString > 0)        // FIXME: add logic for yellow caution here
            {
                greenImage.drawAtPoint(thePoint);
            }
            else
            {
                redImage.drawAtPoint(thePoint);
            }
        }
        let theImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        //cell.theImage.image = theImage
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
        if (indexPath.row == 0)
        {
            performSegueWithIdentifier("Induction", sender: self)
        }
        else if (indexPath.row == 1)
        {
            performSegueWithIdentifier("Incision", sender: self)
        }
        else if (indexPath.row == 2)
        {
            performSegueWithIdentifier("SignOut", sender: self)
        }
    }
    
    func tableView(tableView:UITableView, heightForRowAtIndexPath indexPath:NSIndexPath)->CGFloat {
        return 54
    }
    
    // MARK: tile update functions
    func displayTiles()
    {
        let cells: NSArray = theTableView.visibleCells()
        var imageSize = CGSizeMake(360,40)
        let tileSize = CGSizeMake(40,40)
        let greenImage = UIImage(named: "GreenTile") as UIImage!
        let redImage = UIImage(named: "RedTile") as UIImage!
        var imageRect = CGRectMake(0.0, 0.0, imageSize.width * 4.0, imageSize.height)
        UIGraphicsBeginImageContext(imageSize);
        // Loop through the three buttons
        for var i = 0; i < 3; i++
        {
            var theArray = theModel.getState(i)
            UIGraphicsBeginImageContext(imageSize);
            let theCell = cells[i] as! SSCTableViewCell
            var theEnd = 9
            if (i == 1)
            {
                theEnd = 9
            }
            if (i == 2)
            {
                theEnd = 5
            }
            for var j = 0; j < theEnd; j++
            {
                var theX = CGFloat(j) * tileSize.width
                var thePoint: CGPoint = CGPointMake(theX, 0)
                var modelString = theArray[j]
                if (modelString > 0)   // FIXME: this is where logic for yellow goes
                {
                    greenImage.drawAtPoint(thePoint);
                }
                else
                {
                    redImage.drawAtPoint(thePoint);
                }
            }
            let theImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext();
            theCell.theImage.image = theImage
        }
    }
}