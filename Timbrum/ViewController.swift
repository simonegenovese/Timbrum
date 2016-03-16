//
//  ViewController.swift
//  Timbrum
//
//  Created by Simone Genovese on 23/02/16.
//  Copyright © 2016 ESTECO. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ZucchettiListener, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet var slider: UISlider!
    @IBOutlet var webView: UIWebView!
    @IBOutlet var timeTable: UITableView!
    @IBOutlet var oreResidueLabel: UITextField!
    @IBOutlet var oreResidue: UILabel!
    @IBOutlet var oreTotali: UILabel!
    let defValues = NSUserDefaults.standardUserDefaults()

    var zucchetti = ZucchettiController()

    let ENTRATA: NSNumber = 1.0
    let USCITA: NSNumber = 0.0
    let ORE_LAVORATIVE = "08:00"
    var vc: SettingsViewController?
    var items: [Int: String] = [0: "Ore Lavorate Oggi:", 1:"Ore Residue Oggi:",2:"Ora uscita:"]
    var values: [Int: String] = [0:"00:00", 1:"08:00", 2:"00:00"]

    override func viewDidLoad() {
        super.viewDidLoad()

        //inizializziamo la nostra variabile e la identidichiamo tramite “Secondo”
        vc = self.storyboard?.instantiateViewControllerWithIdentifier("Second") as? SettingsViewController

        self.timeTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")

        // Connect to Zucchetti
        zucchetti.addListener(self)
        connectToServer()
    }

    func connectToServer() {
        // recuperiamo i valori di default dalle impostazioni

        let serverName = defValues.stringForKey("zucchettiServer")
        print("SERVER :\(serverName)")

        let userName = defValues.stringForKey("usrName")
        print("USER :\(userName)")

        let userPswd = defValues.stringForKey("usrPswd")
        print("PSWD :\(userPswd)")

        if (serverName != nil && userName != nil && userPswd != nil) {
            zucchetti.connect(serverName!, usr_name: userName!, user_pswd: userPswd!)
        }

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
        let oreTot = parser.getOreTotali()
        let tmpParser = TimeCounter()
        let firstTime = getTimeInterval(oreTot)
        let secondTime = getTimeInterval(ORE_LAVORATIVE)
        tmpParser.entrata(oreTot)
        tmpParser.uscita(ORE_LAVORATIVE)
        if (firstTime.distanceTo(secondTime) > 0) {
            oreResidueLabel.textColor = UIColor.redColor()
            oreResidueLabel.text = "Ore Residue Oggi:"
        } else {
            oreResidueLabel.textColor = UIColor.blueColor()
            oreResidueLabel.text = "Ore in eccesso:"
        }
        values[0]=oreTot
        values[1]=tmpParser.getOreTotali()
        timeTable.reloadData()
        timeTable.setNeedsDisplay()
        timeTable.setNeedsLayout()
        webView.loadData(data, MIMEType: "text/html", textEncodingName: "UTF-8", baseURL: NSURL(string: "")!)
    }

    @IBAction func cambiaView(sender: AnyObject) {

        //il metodo presentViewController ci consente di passare all’altra vista

        self.presentViewController(vc!, animated: true, completion: nil)

    }

    func getTimeInterval(tempo: String) -> NSTimeInterval {
        let newValue = tempo.stringByReplacingOccurrencesOfString(":", withString: "")
        let hours = newValue.substringWithRange(newValue.startIndex ..< newValue.startIndex.advancedBy(2))
        let minutes = newValue.substringWithRange(newValue.startIndex.advancedBy(2) ..< newValue.startIndex.advancedBy(4))

        return NSTimeInterval(((Double(hours)! * 60) + Double(minutes)!) * 60)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.timeTable.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        cell.textLabel?.text = self.items[indexPath.row]! + " " + self.values[indexPath.row]!
        
        return cell
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
}

