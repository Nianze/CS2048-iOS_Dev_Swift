//
//  FunctionDB.swift
//  MasterDetailView
//
//  Created by lnz on 9/24/16.
//  Copyright © 2016 CS2048 Instructor. All rights reserved.
//

import Foundation
import UIKit

class FunctionDB {
    // Globallyt accessible instance
    static var sharedInstance = FunctionDB()
    
    var functions = ["x", "x**2", "x**3"] {
        didSet {
            NSNotificationCenter.defaultCenter()
                .postNotificationName("FUNCTIONS_DB_CHANGED", object: self)
        }
    }
    
    var thumbnails = [UIImage(named:"x")!, UIImage(named:"x**2")!, UIImage(named: "x**3")!] {
        didSet {
        NSNotificationCenter.defaultCenter().postNotificationName("FUNCTIONS_DB_CHANGED", object: self)
        }
    }
    
}
