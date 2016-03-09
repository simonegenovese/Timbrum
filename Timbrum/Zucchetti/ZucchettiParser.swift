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
        return count.getOreTotali()
    }

    func getTimeTable() -> [String:String] {
        return count.getTimeTable()
    }
}