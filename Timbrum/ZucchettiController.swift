//
//  ZucchettiController.swift
//  Timbrum
//
//  Created by Simone Genovese on 25/02/16.
//  Copyright © 2016 ESTECO. All rights reserved.
//

import Foundation

class ZucchettiController {

    var zucchettiServer = "http://zucchetti.toshiro.it/app_dev.php"
    let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    var zucchettiListener : ZucchettiListener = NullZucchettiListener()
    
    func addListener(listener: ZucchettiListener){
        zucchettiListener = listener
    }
    
    func connect(url_to_request: String ) {
        zucchettiServer = url_to_request
        executeRequest(zucchettiServer,requestParam: "m_cUserName=demo&m_cPassword=demo&m_cAction=login")
    }
    
    func executeRequest(url_to_request: String,requestParam: String){
        let url = NSURL(string: zucchettiServer)
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        let data = (requestParam as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        
        request.HTTPBody = data
        
        let dataTask = session.dataTaskWithRequest(request) {(data, response, error) in
            if error != nil {
                print(error)
                // handle error
            } else {
                // data has a length of 2523 - the contents at the url
                if let httpRes = response as? NSHTTPURLResponse {
                    print(httpRes)
                    self.zucchettiListener.loadComplete(data!)
                }
            }
        }
        dataTask.resume()
    }
}