//
//  ViewController.swift
//  helloWorldIthaca
//
//  Created by lnz on 9/10/16.
//  Copyright © 2016 lnz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var helloLabel: UILabel!
    
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        helloLabel.text = "苟利国家生死以"
    }

    @IBAction func buttonClicked(sender: AnyObject) {
        print("the button was clicked")
        
        helloLabel.text = "我为长者续\(count)秒"
        
        count += 1
        
    }

}

