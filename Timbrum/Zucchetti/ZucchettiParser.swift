//
//  ZucchettiParser.swift
//  Timbrum
//
//  Created by Simone Genovese on 03/03/16.
//  Copyright © 2016 ESTECO. All rights reserved.
//

import Foundation

class ZucchettiParser {

    func parse(data: NSData) -> String {
//        let datastring = NSString(data: data, encoding: NSUTF8StringEncoding) as! String
        var datastring: String = ""
        var jsonResult: NSDictionary
        do {
            jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers) as! NSDictionary
            print(jsonResult)
            let jsonData = jsonResult["Data"]
            let dataIngresso = jsonData![0][0]
            let oraIngresso = jsonData![0][1]
            datastring = "Data: \(dataIngresso) Ora: \(oraIngresso)"
            print(datastring)
        } catch {
            // In questo caso non ci sono risposte JSON ma html
            print(error)
        }
        return datastring
    }
}