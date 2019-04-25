//
//  UIViewExtension.swift
//  Twitter_Assignment
//
//  Created by Diep Thien Lan on 4/25/19.
//  Copyright © 2019 Lan Thien. All rights reserved.
//

import UIKit

extension UIView {
    func makeBoder(color:UIColor, width:CGFloat, cornerRadius:CGFloat) {
        self.clipsToBounds = true
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
        self.layer.cornerRadius = cornerRadius
    }
}
