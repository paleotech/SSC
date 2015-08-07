//
//  SSCModel.swift
//  SSC
//
//  Created by Jim Hurst on 8/5/15.
//  Copyright (c) 2015 Dry Ridge Software. All rights reserved.
//

import Foundation
import UIKit



class SSCModel {

    static let sharedInstance = SSCModel()
    
    struct theDictionaries {
        static var induction: NSMutableDictionary!
        static var incision: NSMutableDictionary!
        static var signOut: NSMutableDictionary!
    }
    
    init()
    {
        theDictionaries.induction = ["identity": 0, "site": 0, "procedure": 0, "consent": 0, "marked": 0, "markingNA": 0, "pulseox": 0, "allergy": 0, "noknownallergy": 0, "noAirwayRisk": 0, "airwayRisk": 0, "noBloodLossRisk": 0, "bloodlossRisk": 0]
        theDictionaries.incision = ["intro": 1, "patient": 1, "site": 0, "procedure": 0, "surgeonreview": 0, "anesthesiareview": 0, "nursingreview": 0, "antibiotics": 0, "antibioticsNA": 0, "imaging": 0, "imagingNA" :0]
        theDictionaries.signOut = ["name": 0, "instruments": 0, "specimen": 0, "equipment": 0, "concerns": 0]
    }
    
    func setState(screen: Int, key: String, value: Int)
    {
        if (screen == 0)
        {
            theDictionaries.induction.setObject(value, forKey:key)
        }
        else if (screen == 1)
        {
            theDictionaries.incision[key] = value
        }
        else if (screen == 2)
        {
            theDictionaries.signOut[key] = value
        }
    }
    
    func getArrayValues(screen: Int) -> [Int]
    {
        if (screen == 0)
        {
            var theArray:[Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0]
            var theStrings: [String] = ["identity", "site", "procedure", "consent", "marked", "markingNA", "pulseox", "allergy", "noknownallergy", "noAirwayRisk", "airwayRisk", "noBloodLossRisk", "bloodlossRisk"]
            // The first four are trivial
            for var i = 0; i < 13; i++
            {
                var theKey: String = theStrings[i]
                theArray[i] = theDictionaries.induction.valueForKey(theKey) as! Int
            }
            return theArray
        }
        else if (screen == 1)
        {
            var theArray:[Int] = [0,0,0,0,0,0,0,0,0,0,0]
            var theStrings: [String] = ["intro", "patient", "site", "procedure", "surgeonreview", "anesthesiareview", "nursingreview", "antibiotics", "antibioticsNA", "imaging", "imagingNA"]
            for var i = 0; i < theStrings.count; i++
            {
                var theKey: String = theStrings[i]
                theArray[i] = theDictionaries.incision[theKey]! as! Int
            }
            return theArray
        }
        else
        {
            var theArray:[Int] = [0,0,0,0,0,0]
            var theStrings: [String] = ["name", "instruments", "specimen", "equipment", "concerns"]
            for var i = 0; i < theStrings.count; i++
            {
                var theKey: String = theStrings[i]
                theArray[i] = theDictionaries.signOut[theKey]! as! Int
            }
            return theArray
        }
    }
    
    func getState(screen: Int) -> [Int]
    {
        
        if (screen == 0)
        {
            var theArray:[Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0]
            var theStrings: [String] = ["identity", "site", "procedure", "consent", "marked", "markingNA", "pulseox", "allergy", "noknownallergy", "noAirwayRisk", "airwayRisk", "noBloodLossRisk", "bloodlossRisk"]
            // The first four are trivial
            for var i = 0; i < 4; i++
            {
                var theKey: String = theStrings[i]
                theArray[i] = theDictionaries.induction.valueForKey(theKey) as! Int
            }
            // The compound ones require special logic
            var marked: Int = theDictionaries.induction.valueForKey("marked") as! Int
            var markingNA: Int = theDictionaries.induction.valueForKey("markingNA") as! Int
            if ( (marked == 1) || (markingNA == 1) )
            {
                theArray[4] = 1;
            }
            var pulseOx: Int = theDictionaries.induction.valueForKey("pulseox") as! Int
            if (pulseOx == 1)
            {
                theArray[5] = 1;
            }
            var allergy: Int = theDictionaries.induction.valueForKey("allergy") as! Int
            var noknownallergy: Int = theDictionaries.induction.valueForKey("noknownallergy") as! Int
            if (allergy == 1)
            {
                theArray[6] = 2;
            }
            else if (noknownallergy == 1)
            {
                theArray[6] = 1;
            }
            var noairwayrisk: Int = theDictionaries.induction.valueForKey("noAirwayRisk") as! Int
            var airwayrisk: Int = theDictionaries.induction.valueForKey("airwayRisk") as! Int
            if (airwayrisk == 1)
            {
                theArray[7] = 2;
            }
            else if (noairwayrisk == 1)
            {
                theArray[7] = 1;
            }
            var nobloodlossrisk: Int = theDictionaries.induction.valueForKey("noBloodLossRisk") as! Int
            var bloodlossrisk: Int = theDictionaries.induction.valueForKey("bloodlossRisk") as! Int
            if (bloodlossrisk == 1)
            {
                theArray[8] = 2;
            }
            else if (nobloodlossrisk == 1)
            {
                theArray[8] = 1;
            }
            
            return theArray
        }
        else if (screen == 1)
        {
            var theArray:[Int] = [0,0,0,0,0,0,0,0,0]
            var theStrings: [String] = ["intro", "patient", "site", "procedure", "surgeonreview", "anesthesiareview", "nursingreview", "antibiotics", "antibioticsNA", "imaging", "imagingNA"]
            for var i = 0; i < 7; i++
            {
                var theKey: String = theStrings[i]
                theArray[i] = theDictionaries.incision.valueForKey(theKey) as! Int
            }
            var antibioticGiven: Int = theDictionaries.incision.valueForKey("antibiotics") as! Int
            var antibioticNA: Int = theDictionaries.incision.valueForKey("antibioticsNA") as! Int
            if ((antibioticGiven == 1) || (antibioticNA == 1) )
            {
                theArray[7] = 1;
            }
            var imaging: Int = theDictionaries.incision.valueForKey("imaging") as! Int
            var imagingNA: Int = theDictionaries.incision.valueForKey("imagingNA") as! Int
            if ((imaging == 1) || (imagingNA == 1) )
            {
                theArray[8] = 1;
            }
            return theArray
        }
        else
        {
            var theArray:[Int] = [0,0,0,0,0,0]
            var theStrings: [String] = ["name", "instruments", "specimen", "equipment", "concerns"]
            for var i = 0; i < theStrings.count; i++
            {
                var theKey: String = theStrings[i]
                theArray[i] = theDictionaries.signOut.valueForKey(theKey) as! Int
            }
            return theArray
        }
        
    }
}
