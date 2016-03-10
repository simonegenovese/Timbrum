//
//  ZucchettiParser.swift
//  Timbrum
//
//  Created by Simone Genovese on 03/03/16.
//  Copyright © 2016 ESTECO. All rights reserved.
//

import Foundation

class ZucchettiParser {
    var count = TimeCounter()

    func parse(data: NSData) -> String {
        var datastring: String = ""
        var jsonResult: NSDictionary
        do {
            jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            let jsonData = jsonResult["Data"] as! NSArray
            for row in jsonData {
                if row is NSArray {
                    if String("E") == (row[2] as! String) {
                        count.entrata(row[1] as! String)
                    } else {
                        count.uscita(row[1] as! String)
                    }
                } else {
                    // obj is not an Array
                }
            }
            let dataIngresso = jsonData[0][0]
            let oraIngresso = jsonData[0][1]
            datastring = "Data"
            print("Data: \(dataIngresso) Ora: \(oraIngresso)")
        } catch {
            // In questo caso non ci sono risposte JSON ma html
            print(error)
        }
        return datastring
    }

    func getOreTotali() -> String {
        var last = "U"
        let tmpCount = TimeCounter()
        let sortedTimeTable = count.getTimeTable().sort { (map0, map1) -> Bool in
            let firstTime = getTimeInterval(map0.0)
            let secondTime = getTimeInterval(map1.0)
            return firstTime.distanceTo(secondTime)>0
        }
        for (time, operation) in sortedTimeTable {
            last = operation
            if operation == "E" {
                tmpCount.entrata(time)
            } else{
                tmpCount.uscita(time)
            }
        }
        if last == "E" {
            let date = NSDate()
            let calendar = NSCalendar.currentCalendar()
            let components = calendar.components([.Hour, .Minute], fromDate: date)
            let hour = components.hour
            let minutes = components.minute
            tmpCount.uscita("\(hour):\(minutes)")
            return tmpCount.getOreTotali()
        }
        return count.getOreTotali()
    }
    
    func getTimeInterval(tempo: String) -> NSTimeInterval{
        let newValue = tempo.stringByReplacingOccurrencesOfString(":", withString: "")
        let hours = newValue.substringWithRange(newValue.startIndex ..< newValue.startIndex.advancedBy(2))
        let minutes = newValue.substringWithRange(newValue.startIndex.advancedBy(2) ..< newValue.startIndex.advancedBy(4))
       
        return NSTimeInterval(((Double(hours)! * 60) + Double(minutes)!)*60)
    }

    func getTimeTable() -> [String:String] {
        return count.getTimeTable()
    }
}