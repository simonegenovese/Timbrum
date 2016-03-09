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


    func sum(value: String) {
        let hours = value.substringWithRange(value.startIndex ..< value.startIndex.advancedBy(2))
        let minutes = value.substringWithRange(value.startIndex.advancedBy(2) ..< value.startIndex.advancedBy(4))

        let count =  todayInterval.advancedBy((Double(hours)!*60)+Double(minutes)!)
        
        todayInterval = NSTimeInterval(count)
    }

    func remove(value: String) {
        let hours = value.substringWithRange(value.startIndex ..< value.startIndex.advancedBy(2))
        let minutes = value.substringWithRange(value.startIndex.advancedBy(2) ..< value.startIndex.advancedBy(4))
        let from =  NSTimeInterval((Double(hours)!*60)+Double(minutes)!)
        
        let count =  from.distanceTo(todayInterval)
        
        todayInterval = NSTimeInterval(count)
    }

    func getOreTotali() -> String {
        let  minutes = floor(todayInterval/60)
        let seconds = trunc(todayInterval - minutes * 60)
        let text = NSString().stringByAppendingFormat("%02d:%02d", NSInteger(minutes), NSInteger(seconds))
        return text as String
    }
}