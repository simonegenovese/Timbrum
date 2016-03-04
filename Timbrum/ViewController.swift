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
    let ZUCCHETTI_SERVER = "http://saas.hrzucchetti.it/hrpergon"
//    let ZUCCHETTI_SERVER = "http://zucchetti.toshiro.it/app_dev.php"

    var zucchetti = ZucchettiController()
    let ENTRATA: NSNumber = 1.0
    let USCITA: NSNumber = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Connect to Zucchetti
        zucchetti.addListener(self)
        zucchetti.connect(ZUCCHETTI_SERVER)
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
//        let parser = ZucchettiParser()
//        let time = parser.parse(data)
    }
}

