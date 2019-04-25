//
//  ViewController.swift
//  Twitter_Assignment
//
//  Created by Diep Thien Lan on 4/24/19.
//  Copyright © 2019 Lan Thien. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func splitMessage(_ message:String) -> [String] {
        var messages = [String]()
        let remainString = String(stringLiteral: message)
        
        while remainString.count >= 50 {
            let newString = String(remainString[0..<50])
            
        }
        
        return messages
    }
}

