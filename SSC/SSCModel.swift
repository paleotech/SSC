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
    
    var induction: Dictionary<String, Int> = ["identity": 0, "site": 0, "procedure": 0, "consent": 0, "marked": 0, "markingNA": 0, "pulseox": 0, "allergy": 0, "noknownallergy": 0, "noAirwayRisk": 0, "airwayRisk": 0, "noBloodlossRisk": 0, "bloodlossRisk": 0]
    var incision: Dictionary<String, Int> = ["intro": 1, "patient": 1, "site": 0, "procedure": 0, "surgeonreview": 0, "anesthesiareview": 0, "nursingreview": 0, "antibiotics": 0, "antibioticsNA": 0, "imaging": 0, "imagingNA" :0]
    var signOut: Dictionary<String, Int> = ["name": 0, "instruments": 0, "specimen": 0, "equipment": 0, "concerns": 0]
    
    func setState(screen: Int, key: String, value: Int)
    {
        if (screen == 0)
        {
            self.induction[key] = value
        }
        else if (screen == 1)
        {
            incision[key] = value
        }
        else if (screen == 2)
        {
            signOut[key] = value
        }
    }
    
    func getState(screen: Int) -> [Int]
    {
        
        if (screen == 0)
        {
            var theArray:[Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0]
            var theStrings: [String] = ["identity", "site", "procedure", "consent", "marked", "markingNA", "pulseox", "allergy", "noknownallergy", "noAirwayRisk", "airwayRisk", "noBloodlossRisk", "bloodlossRisk"]
            for var i = 0; i < theStrings.count; i++
            {
                var theKey: String = theStrings[i]
                theArray[i] = induction[theKey]!
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
                theArray[i] = incision[theKey]!
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
                theArray[i] = signOut[theKey]!
            }
            return theArray
        }
        
    }
}
