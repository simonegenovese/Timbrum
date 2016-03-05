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
        } catch {
            print(error)
        }
        return datastring
    }
}