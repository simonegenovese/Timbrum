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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        var sliderPosition:Double = 0.5
        if value == 1 || value == (0.0) {
            sliderPosition = Double(value)
            print("Hai Timbrato = \(value)")
            let zucchetti = ZucchettiController()
            zucchetti.data_request("http://www.google.it", listener: self)
          
        }
        return sliderPosition
    }
    
    func loadComplete(data: NSData){
          webView.loadData(data, MIMEType: "text/html", textEncodingName: "UTF-8", baseURL: NSURL(string: "")!)
    }
}

