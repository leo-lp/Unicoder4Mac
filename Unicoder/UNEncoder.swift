//
//  UNEncoder.swift
//  Unicoder
//
//  Created by Fnoz on 16/7/29.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

import Cocoa
import Foundation
import AppKit

func UnicodeEncode(_ string:NSString) -> NSString {
    let data = string.data(using: String.Encoding.nonLossyASCII.rawValue)
    return NSString.init(data: data!, encoding: String.Encoding.utf8.rawValue)!
}

func UnicodeDecode(_ string:NSString) -> NSString {
    let data = string.data(using: String.Encoding.utf8.rawValue)
    var resultStr = NSString.init(data: data!, encoding: String.Encoding.nonLossyASCII.rawValue)
    if resultStr == nil {
        resultStr = ""
    }
    return resultStr!
}

func URLEncode(_ string: NSString) -> NSString {
    return string.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)! as NSString
}

func URLDecode(_ string: NSString) -> NSString {
    return string.removingPercentEncoding! as NSString
}

func Base64Encode(_ string: NSString) -> NSString {
    let encodedData = string.data(using: String.Encoding.utf8.rawValue)
    return (encodedData?.base64EncodedString(options: .lineLength64Characters))! as NSString
}

func Base64Decode(_ string: NSString) -> NSString {
    if let decodedData = Data.init(base64Encoded: string as String, options: .ignoreUnknownCharacters) {
        return NSString.init(data: decodedData, encoding: String.Encoding.utf8.rawValue)!
    } else {
        return string
    }
}

func Escape(_ string: NSString) -> NSString {
    let result = NSMutableString.init(string: "")
    for i in 0 ... string.length - 1 {
        let uc = string.substring(with: NSRange.init(location: i, length: 1))
        switch uc {
        case "\"":
            result.append("\\\"")
            break
        case "\'":
            result.append("\\\'")
            
            break
        case "\\":
            result.append("\\\\")
            break
        case "\t":
            result.append("\\t")
            break
        case "\n":
            result.append("\\n")
            break
        case "\r":
            result.append("\\r")
            break
        case "\u{8}":
            result.append("\\u{8}")
            break
        case "\u{12}":
            result.append("\\u{12}")
        default:
            result.append(uc)
            break
        }
    }
    return result.copy() as! String as NSString
}
