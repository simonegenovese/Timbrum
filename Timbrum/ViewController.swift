//
//  ViewController.swift
//  Timbrum
//
//  Created by Simone Genovese on 23/02/16.
//  Copyright © 2016 ESTECO. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ZucchettiListener, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var timeTable: UITableView!
    @IBOutlet weak var uscita: UIButton!
    @IBOutlet weak var entrata: UIButton!

    let defValues = NSUserDefaults.standardUserDefaults()
    let ENTRATA: NSNumber = 1.0
    let USCITA: NSNumber = 0.0
    let ORE_LAVORATIVE = "08:00"
    let refreshControl = UIRefreshControl()

    var zucchetti = ZucchettiController()
    var vc: SettingsViewController?
    var items: [Int:String] = [0: "Ore Lavorate Oggi:", 1: "Ore Residue Oggi:", 2: "Ora uscita:"]
    var values: [Int:String] = [0: "00:00", 1: "08:00", 2: "00:00"]

    override func viewDidLoad() {
        super.viewDidLoad()

        refreshControl.backgroundColor = UIColor.whiteColor()
        refreshControl.tintColor = UIColor.blueColor()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(ViewController.reloadData), forControlEvents: UIControlEvents.ValueChanged)
        timeTable.addSubview(refreshControl)

        //inizializziamo la nostra variabile e la identidichiamo tramite “Secondo”
        vc = self.storyboard?.instantiateViewControllerWithIdentifier("Second") as? SettingsViewController

        self.timeTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")

        // Connect to Zucchetti
        zucchetti.addListener(self)
        connectToServer()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logButtonEvent(sender: UIButton) {
        let timbratura = sender.currentTitle!
        print("press button = \(timbratura)")

        //TODO occorrerebbe verificare se siamo già nello stato voluto: es premo uscita ma sono già uscito...
        switch timbratura {
        case "entrata": zucchetti.enter()
        case "uscita": zucchetti.exit()

        default: break
        }
        zucchetti.loadAccessLog()
        self.timeTable.reloadData()
    }

    @IBAction func cambiaView(sender: AnyObject) {
        //il metodo presentViewController ci consente di passare all’altra vista
        self.presentViewController(vc!, animated: true, completion: nil)
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

    func reloadData() {
        print("--Refresh--")
        zucchetti.loadAccessLog()
    }

    func loadComplete(data: NSData) {
        refreshControl.endRefreshing()
        let parser = ZucchettiParser()
        parser.parse(data)
        let oreTot = parser.getOreTotali()
        let tmpParser = TimeCounter()
        tmpParser.entrata(oreTot)
        tmpParser.uscita(ORE_LAVORATIVE)
        values[0] = oreTot
        values[1] = tmpParser.getOreTotali()
        addEnterExitToTimeTalbe(parser)
        dispatch_async(dispatch_get_main_queue(), {
            self.timeTable.reloadData()
        });
    }

    func addEnterExitToTimeTalbe(parser: ZucchettiParser) {
        let sortedTimeTable = parser.getTimeTable().sort {
            (map0, map1) -> Bool in
            let firstTime = getTimeInterval(map0.0)
            let secondTime = getTimeInterval(map1.0)
            return firstTime.distanceTo(secondTime) > 0
        }
        for (time, operation) in sortedTimeTable {
            if (!items.values.contains(time)) {
                items[items.count] = time
                values[values.count] = operation
            }
        }
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
        let cell: UITableViewCell = self.timeTable.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell

        cell.textLabel?.text = self.items[indexPath.row]! + " " + self.values[indexPath.row]!
        cell.detailTextLabel?.text = "More text";

        var cellLabel:String = "";
        cellLabel = (cell.textLabel?.text)!

//        cambiare icona in base all'azione!
//        cell.imageView!.image = UIImage(named: "gear.png")
        
        let ultimoCar:String = (cellLabel.substringFromIndex(cellLabel.endIndex.predecessor()))
        if(ultimoCar == "E") {
            cell.imageView!.image = UIImage(named: "enter32.png")
        } else if(ultimoCar == "U"){
            cell.imageView!.image = UIImage(named: "exit32.png")
        } else {
            cell.imageView!.image = UIImage(named: "gear.png")
        }

        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Cell selected #\(indexPath.row)!")
    }
}

