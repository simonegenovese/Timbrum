//
//  ZucchettiController.swift
//  Timbrum
//
//  Created by Simone Genovese on 25/02/16.
//  Copyright © 2016 ESTECO. All rights reserved.
//

import Foundation

class ZucchettiController {
    
    var zucchettiServer: String!
    let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    var zucchettiListener: ZucchettiListener = NullZucchettiListener()

    func addListener(listener: ZucchettiListener) {
        zucchettiListener = listener
    }

    func connect(url_to_request: String, usr_name: String, user_pswd: String) {
        zucchettiServer = url_to_request
        executeRequest("\(zucchettiServer)/servlet/cp_login", requestParam: "m_cUserName=\(usr_name)&m_cPassword=\(user_pswd)&m_cAction=login")
    }
    
    func connect(url_to_request: String) {
        connect(url_to_request, usr_name: "demo", user_pswd: "demo")
    }

    func enter() {
        executeRequest("\(zucchettiServer)/servlet/ushp_ftimbrus", requestParam: "verso=E")
    }

    func exit() {
        executeRequest("\(zucchettiServer)/servlet/ushp_ftimbrus", requestParam: "verso=U")
    }

    func loadAccessLog() {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let today = NSDate()
        let enterDate = dateFormatter.stringFromDate(today)
        let request = "rows=16&startrow=0&count=false&cmdhash=7307015ecef178a88c60a36b1d82e67b&sqlcmd=ushp_qtimbrus&ADATE=\(enterDate)"
        executeRequest("\(zucchettiServer)/servlet/SQLDataProviderServer", requestParam: request)
    }

    func executeRequest(url_to_request: String, requestParam: String) {
        let url = NSURL(string: url_to_request)
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        let data = (requestParam as NSString).dataUsingEncoding(NSUTF8StringEncoding)

        request.HTTPBody = data

        let dataTask = session.dataTaskWithRequest(request) {
            (data, response, error) in
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