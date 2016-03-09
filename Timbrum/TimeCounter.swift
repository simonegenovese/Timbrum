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
    var todayInterval = NSTimeInterval()
    var timeTable = [String: String]()

    func sum(value: String) {
        let hours = value.substringWithRange(value.startIndex ..< value.startIndex.advancedBy(2))
        let minutes = value.substringWithRange(value.startIndex.advancedBy(2) ..< value.startIndex.advancedBy(4))

        let count =  todayInterval.advancedBy((Double(hours)!*60)+Double(minutes)!)
        timeTable["\(hours):\(minutes)"] = "E"
        todayInterval = NSTimeInterval(count)
    }

    func remove(value: String) {
        let hours = value.substringWithRange(value.startIndex ..< value.startIndex.advancedBy(2))
        let minutes = value.substringWithRange(value.startIndex.advancedBy(2) ..< value.startIndex.advancedBy(4))
        let from =  NSTimeInterval((Double(hours)!*60)+Double(minutes)!)
        
        let count =  from.distanceTo(todayInterval)
        timeTable["\(hours):\(minutes)"] = "U"
        todayInterval = NSTimeInterval(count)
    }

    func getOreTotali() -> String {
        let  hours = floor(todayInterval/60)
        let minutes = trunc(todayInterval - hours * 60)
        let text = NSString().stringByAppendingFormat("%02d:%02d", NSInteger(hours), NSInteger(minutes))
        return text as String
    }
    
    func getTimeTable() -> [String: String] {
        return timeTable
    }
}