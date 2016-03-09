//
//  TimeCounter.swift
//  Timbrum
//
//  Created by Simone Genovese on 05/03/16.
//  Copyright © 2016 ESTECO. All rights reserved.
//

import Foundation
import UIKit


class TimeCounter {
    let userCalendar = NSCalendar.currentCalendar()
    
    var timeToday = NSDate()
  
    init(){
                let mothersDayComponent = NSDateComponents()
        
                mothersDayComponent.year = 2016
        
                mothersDayComponent.month = 3
        
                mothersDayComponent.day = 9
        
                mothersDayComponent.hour = 0
        
                mothersDayComponent.minute = 0
        
                timeToday = userCalendar.dateFromComponents(mothersDayComponent)!
    }
    
    func sum(value : String ){

        
        
        let addingPeriod = NSDateComponents()
        
        let hours = value.substringWithRange(value.startIndex..<value.startIndex.advancedBy(2))
        addingPeriod.hour = Int(hours)!
        
        let minutes = value.substringWithRange(value.startIndex.advancedBy(2)..<value.startIndex.advancedBy(4))
        addingPeriod.minute = Int(minutes)!
        
        if let newYearsParty = userCalendar.dateByAddingComponents(addingPeriod, toDate: timeToday, options: []) {
            
            let dateformatter = NSDateFormatter()
            
            dateformatter.dateStyle = NSDateFormatterStyle.MediumStyle
            
            dateformatter.timeStyle = NSDateFormatterStyle.ShortStyle
            
            print(dateformatter.stringFromDate(newYearsParty))
        }
    }
    
    func remove( value : String){
        
    }
    
    func getOreTotali() -> String {
        return ""
    }
}