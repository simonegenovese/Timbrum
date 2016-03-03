//
//  NullZipListener.swift
//  Timbrum
//
//  Created by Simone Genovese on 02/03/16.
//  Copyright © 2016 ESTECO. All rights reserved.
//

import Foundation

class NullZucchettiListener: ZucchettiListener {
    func loadComplete(data: NSData) {
        let resstr = NSString(data: data, encoding: NSUTF8StringEncoding)
        print(resstr)
    }
}