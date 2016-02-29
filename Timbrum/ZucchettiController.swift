//
//  ZucchettiController.swift
//  Timbrum
//
//  Created by Simone Genovese on 25/02/16.
//  Copyright © 2016 ESTECO. All rights reserved.
//

import Foundation

class ZucchettiController {
    
    func data_request(url_to_request: String, listener: ZucchettiListener) {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let url = NSURL(string: url_to_request)
        let request = NSMutableURLRequest(URL: url!)
        let dataTask = session.dataTaskWithRequest(request) {(data, response, error) in
            if error != nil {
                print(error)
                // handle error
            } else {
                // data has a length of 2523 - the contents at the url
                if let httpRes = response as? NSHTTPURLResponse {
                    print(httpRes)
                    listener.loadComplete(data!)
                }
            }
        }
        dataTask.resume()
    }
    

}