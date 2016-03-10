//
//  SettingsViewController.swift
//  Timbrum
//
//  Created by Simone Genovese on 09/03/16.
//  Copyright © 2016 ESTECO. All rights reserved.
//

import UIKit
class SettingsViewController: UIViewController {
    
    let defValues = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var zucchettiServer: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // sincronizziamo le impostazioni di default
        userName.text = defValues.stringForKey("usrName")
        userPassword.text = defValues.stringForKey("usrPswd")
        zucchettiServer.text = defValues.stringForKey("zucchettiServer")
    }
    
    @IBAction func indietro(sender: AnyObject) {
        dismissViewControllerAnimated(true , completion: nil);
        // facciamo un check per vedere se le impostazioni sono modificate ed in caso suggeriamo di salvare?
    }
    
    @IBAction func saveSettings(sender: UIButton) {
        // sincronizziamo le impostazioni di default
        
        guard !self.userName.text!.isEmpty else {
            return
        }
        
        guard !self.userPassword.text!.isEmpty else {
            return
        }
        
        guard !self.zucchettiServer.text!.isEmpty else {
            return
        }
        
        let usrnome = self.userName.text!
        let usrpswd = self.userPassword.text!
        let servnome = self.zucchettiServer.text!
        
        print("salvo: \(usrnome), \(usrpswd), \(servnome)")
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