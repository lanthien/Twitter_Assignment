//
//  Utilities.swift
//  Twitter_Assignment
//
//  Created by Diep Thien Lan on 4/25/19.
//  Copyright © 2019 Lan Thien. All rights reserved.
//

import Foundation

class Utilities {
    
    public static func splitMessage(_ message:String) throws -> [String] {
        if (message.count <= 50) {
            return [message]
        }
        
        var messages = [String]()
        var addCharCount = 4
        var remainString = String(message)
        var sttArr = [String]()
        var index = 1
        let sub = 50 - addCharCount
        
        let tempArr = remainString.split(separator: " ")
                                .filter { $0.count > 50}
        if tempArr.count > 0 {
            throw SplitMessageError.NotHaveSpaceCharactor
        }
        
        while remainString.count > sub {
            let stt = "\(index)/\(index) "
            sttArr.append(stt)
            
            var newString = String(remainString[0..<50-stt.count])
            remainString.removeString(in: 0..<50-stt.count)
            var arr = newString.components(separatedBy: " ")
            arr = arr.filter { $0.count > 0 }
            if newString.last != " " && remainString.first != " " {
                let removedString = arr.removeLast()
                remainString.insert(contentsOf: removedString,
                                    at: remainString.startIndex)
            }
            newString = arr.joined(separator: " ")
            messages.append(newString)
            
            if addCharCount < stt.count {
                addCharCount = stt.count
                updateArr(sttArr: &sttArr, arr: &messages, remainString: &remainString)
            }
            
            index += 1
        }
        
        //Add remain characters
        let stt = "\(index)/\(index) "
        sttArr.append(stt)
        messages.append(remainString)
        updateArr(sttArr: &sttArr, arr: &messages, remainString: &remainString)
        
        return joinString(stt: sttArr, messages: messages);
    }
    
    private static func updateArr(sttArr:inout [String],
                                  arr:inout [String],
                                  remainString:inout String) {
        let count = sttArr.count
        for index in 0..<count {
            let text = "\(index + 1)/\(count) "
            sttArr[index] = text
            
            while text.count + arr[index].count > 50 {
                guard let lastString = arr[index].components(separatedBy: " ").last
                    else { continue }
                var arr1 = arr[index].components(separatedBy: " ")
                arr1.removeLast()
                arr[index] = arr1.joined(separator: " ")
                if index < count - 2 {
                    arr[index+1].insert(contentsOf: "\(lastString) ", at: arr[index+1].startIndex)
                }
                else {
                    remainString.insert(contentsOf: "\(lastString) ", at: remainString.startIndex)
                }
            }
        }
    }
    
    private static func joinString(stt: [String], messages:[String]) -> [String] {
        var result = [String]()
        _ = messages.count
        for (index,value) in messages.enumerated() {
            var string = value
            if (index < stt.count) {
                string.insert(contentsOf: stt[index], at: string.startIndex)
            }
            result.append(string)
        }
        
        print(result)
        return result
    }
}
