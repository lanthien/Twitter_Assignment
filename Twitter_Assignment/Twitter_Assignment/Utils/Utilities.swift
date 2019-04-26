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
        var maxOrderLength = 4
        
        //Encode String to Unicode
        let dataenc = message.data(using: String.Encoding.nonLossyASCII)
        guard var remainString = String(data: dataenc!, encoding: String.Encoding.utf8)
            else { return [message] }
        
        var orderStrings = [String]()
        var index = 1
        let numOfChar = 50 - maxOrderLength
        
        //Check word has more than 50 characters
        let tempArr = remainString.split(separator: " ")
                                .filter { $0.count > 50}
        if tempArr.count > 0 {
            throw SplitMessageError.NotHaveSpaceCharactor
        }
        
        while remainString.count > numOfChar {
            let orderStr = "\(index)/\(index) "
            orderStrings.append(orderStr)
            
            var newString = String(remainString[0..<50-orderStr.count])
            remainString.removeString(in: 0..<50-orderStr.count)
            var arr = newString.components(separatedBy: " ")
            arr = arr.filter { $0.count > 0 }
            if newString.last != " " && remainString.first != " " {
                let removedString = arr.removeLast()
                remainString.insert(contentsOf: removedString,
                                    at: remainString.startIndex)
            }
            newString = arr.joined(separator: " ")
            messages.append(newString)
            
            if maxOrderLength < orderStr.count {
                maxOrderLength = orderStr.count
                updateArr(orderStrings: &orderStrings, messages: &messages, remainString: &remainString)
            }
            
            index += 1
        }
        
        //Add remain characters
        let stt = "\(index)/\(index) "
        orderStrings.append(stt)
        messages.append(remainString)
        updateArr(orderStrings: &orderStrings, messages: &messages, remainString: &remainString)
        
        return joinString(stt: orderStrings, messages: messages);
    }
    
    private static func updateArr(orderStrings:inout [String],
                                  messages:inout [String],
                                  remainString:inout String) {
        let count = orderStrings.count
        for index in 0..<count {
            let text = "\(index + 1)/\(count) "
            orderStrings[index] = text
            
            while text.count + messages[index].count > 50 {
                guard let lastString = messages[index].components(separatedBy: " ").last
                    else { continue }
                var tmp = messages[index].components(separatedBy: " ")
                tmp.removeLast()
                messages[index] = tmp.joined(separator: " ")
                if index < count - 2 {
                    messages[index+1].insert(contentsOf: "\(lastString) ", at: messages[index+1].startIndex)
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
            
            if let data = string.data(using: .utf8),
                let message = String(data: data, encoding: .nonLossyASCII){
                result.append(message)
            }
        }
        print(result)
        return result
    }
}
