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

    func entrata(value: String) {
        let newValue = value.stringByReplacingOccurrencesOfString(":", withString: "")
        let hours = newValue.substringWithRange(newValue.startIndex ..< newValue.startIndex.advancedBy(2))
        let minutes = newValue.substringWithRange(newValue.startIndex.advancedBy(2) ..< newValue.startIndex.advancedBy(4))

        let count = todayInterval.advancedBy(((Double(hours)! * 60) + Double(minutes)!)*60)
        timeTable["\(hours):\(minutes)"] = "E"
        todayInterval = NSTimeInterval(count)
    }

    func uscita(value: String) {
        let newValue = value.stringByReplacingOccurrencesOfString(":", withString: "")
        let hours = newValue.substringWithRange(newValue.startIndex ..< newValue.startIndex.advancedBy(2))
        let minutes = newValue.substringWithRange(newValue.startIndex.advancedBy(2) ..< newValue.startIndex.advancedBy(4))
        let from = NSTimeInterval(((Double(hours)! * 60) + Double(minutes)!)*60)

        let count = -from.distanceTo(todayInterval)
        timeTable["\(hours):\(minutes)"] = "U"
        todayInterval = NSTimeInterval(count)
    }

    func getOreTotali() -> String {
        let hours = floor(todayInterval / 3600)
        let minutes = trunc(todayInterval / 60 - hours * 60)
        let text = NSString().stringByAppendingFormat("%02d:%02d", NSInteger(hours), NSInteger(minutes))
        return text as String
    }

    func getTimeTable() -> [String:String] {
        return timeTable
    }
}