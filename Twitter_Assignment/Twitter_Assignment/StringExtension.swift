//
//  StringExtension.swift
//  Twitter_Assignment
//
//  Created by Diep Thien Lan on 4/24/19.
//  Copyright © 2019 Lan Thien. All rights reserved.
//

import Foundation

extension String {
    subscript (value:Range<Int>) -> Substring {
        let lowerBound = String.Index(encodedOffset: value.lowerBound)
        let upperBound = String.Index(encodedOffset: value.upperBound)
        return self[lowerBound..<upperBound]
    }
}
