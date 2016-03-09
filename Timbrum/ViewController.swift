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
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var zucchettiServer: UITextField!
    
//    let ZUCCHETTI_SERVER = "http://saas.hrzucchetti.it/hrpergon"
    let ZUCCHETTI_SERVER = "http://zucchetti.toshiro.it/app_dev.php"

    @IBOutlet var oreResidue: UILabel!
    @IBOutlet var oreTotali: UILabel!
    
    var zucchetti = ZucchettiController()
    
    let ENTRATA: NSNumber = 1.0
    let USCITA: NSNumber = 0.0
    
    @IBOutlet var timeTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Connect to Zucchetti
        zucchetti.addListener(self)
        connectToServer()
    }
    
    func connectToServer() {
        var server: String!
        if zucchettiServer != nil {
            server = zucchettiServer.text
        } else {
            server = ZUCCHETTI_SERVER
        }
        print("Connessione al server: \(server)")
       
        var usr: String!
        if(userName != nil) {
            usr = userName.text
        } else {
            usr = "demo"
        }
        print("Username: \(usr)")
        
        var pswd: String!
        if(userPassword != nil) {
            pswd = userPassword.text
        } else {
            pswd = "demo"
        }
        print("Password: \(pswd)")
        
        
        zucchetti.connect(server, usr_name: usr, user_pswd: pswd)
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
        webView.loadData(data, MIMEType: "text/html", textEncodingName: "UTF-8", baseURL: NSURL(string: "")!)
        let parser = ZucchettiParser()
        parser.parse(data)
        oreTotali.text=parser.getOreTotali()
        let tmpParser = TimeCounter()
        tmpParser.entrata(parser.getOreTotali())
        tmpParser.uscita("08:00")
        oreResidue.text=tmpParser.getOreTotali()
    }
}

