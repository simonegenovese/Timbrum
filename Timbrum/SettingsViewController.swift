//
//  SettingsViewController.swift
//  Timbrum
//
//  Created by Simone Genovese on 09/03/16.
//  Copyright © 2016 ESTECO. All rights reserved.
//

import UIKit
class SettingsViewController: UIViewController {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var zucchettiServer: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    @IBAction func indietro(sender: AnyObject) {
        dismissViewControllerAnimated(true , completion: nil);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getZucchettiServer() -> String? {
        if zucchettiServer == nil {
            return nil
        } else {
            return zucchettiServer.text
        }
    }
    
    func getUserName() -> String? {
        if userName == nil {
            return nil
        } else {
            return userName.text
        }
    }
    
    func getUserPassword() -> String? {
        if userName == nil {
            return nil
        } else {
            return userPassword.text
        }
    }
}