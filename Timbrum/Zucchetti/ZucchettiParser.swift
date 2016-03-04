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
        let datastring = NSString(data: data, encoding: NSUTF8StringEncoding) as! String
        // Parse data..
        return datastring
    }
}