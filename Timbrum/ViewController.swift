//
//  ViewController.swift
//  Timbrum
//
//  Created by Simone Genovese on 23/02/16.
//  Copyright © 2016 ESTECO. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ZucchettiListener {
    @IBOutlet var slider: UISlider!
    @IBOutlet var webView: UIWebView!

    let defValues = NSUserDefaults.standardUserDefaults()
    
//    let ZUCCHETTI_SERVER = "http://saas.hrzucchetti.it/hrpergon"
//    let ZUCCHETTI_SERVER = "http://zucchetti.toshiro.it/app_dev.php"

    @IBOutlet var oreResidue: UILabel!
    @IBOutlet var oreTotali: UILabel!
    
    var zucchetti = ZucchettiController()
    
    let ENTRATA: NSNumber = 1.0
    let USCITA: NSNumber = 0.0
    var vc: SettingsViewController?
    @IBOutlet var timeTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //inizializziamo la nostra variabile e la identidichiamo tramite “Secondo”
        vc = self.storyboard?.instantiateViewControllerWithIdentifier("Second") as? SettingsViewController
        
        // Connect to Zucchetti
        zucchetti.addListener(self)
        connectToServer()
    }
    
    func connectToServer() {
        // recuperiamo i valori di default dalle impostazioni
        
        let serverName = defValues.stringForKey("zucchettiServer")
        print ("SERVER :\(serverName)")
        
        let userName = defValues.stringForKey("usrName")
        print ("USER :\(userName)")
        
        let userPswd = defValues.stringForKey("usrPswd")
        print ("PSWD :\(userPswd)")
        
        if(serverName != nil && userName != nil && userPswd != nil) {
            zucchetti.connect(serverName!, usr_name: userName!, user_pswd: userPswd!)
        }
        
        
//        var server: String!
//        if vc!.getZucchettiServer() != nil {
//            server = vc!.getZucchettiServer()
//        } else {
//            server = ZUCCHETTI_SERVER
//        }
//        print("Connessione al server: \(server)")
//       
//        var usr: String!
//        if(vc!.getUserName() != nil) {
//            usr = vc!.getUserName()
//        } else {
//            usr = "demo"
//        }
//        print("Username: \(usr)")
//        
//        var pswd: String!
//        if(vc!.getUserPassword() != nil) {
//            pswd = vc!.getUserPassword()
//        } else {
//            pswd = "demo"
//        }
//        print("Password: \(pswd)")
//        zucchetti.connect(server, usr_name: usr, user_pswd: pswd)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logEvent(sender: UISlider) {
        let value = sender.value
        let newPosition = checkSlider(value)
        slider.setValue(Float(newPosition), animated: true)
    }

    func checkSlider(value: Float) -> Double {
        print("value = \(value)")
        var sliderPosition: Double = 0.5
        if value == ENTRATA {
            sliderPosition = Double(value)
            print("Hai Timbrato Entrata= \(value)")
            zucchetti.enter()
        } else if value == USCITA {
            sliderPosition = Double(value)
            print("Hai Timbrato Uscita = \(value)")
            zucchetti.exit()
        } else {
            print("Refresh")
            zucchetti.loadAccessLog()
        }
        return sliderPosition
    }

    func loadComplete(data: NSData) {
        let parser = ZucchettiParser()
        parser.parse(data)
        oreTotali.text=parser.getOreTotali()
        let tmpParser = TimeCounter()
        tmpParser.entrata(parser.getOreTotali())
        tmpParser.uscita("08:00")
        oreResidue.text=tmpParser.getOreTotali()
        webView.loadData(data, MIMEType: "text/html", textEncodingName: "UTF-8", baseURL: NSURL(string: "")!)

    }
    
    @IBAction func cambiaView(sender: AnyObject) {
        
        //il metodo presentViewController ci consente di passare all’altra vista
        
        self.presentViewController(vc!, animated: true, completion: nil)
        
    }
}

