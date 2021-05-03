//
//  JSONSerialization.swift
//  Movieland
//
//  Created by Dante Solorio on 03/05/21.
//

import Foundation

enum JSONSerializationError: Error {
    case invalidString
    case invalidObject
}

extension JSONSerialization {
    class func jsonObject(with string: String, options: JSONSerialization.ReadingOptions = []) throws -> Any {
        guard let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false) else { throw JSONSerializationError.invalidString }
        return try JSONSerialization.jsonObject(with: data, options: options)
    }
    
    class func string(with jsonObject: Any, options: JSONSerialization.WritingOptions = []) throws -> String {
        guard JSONSerialization.isValidJSONObject(jsonObject) else { throw JSONSerializationError.invalidObject }
        let data = try JSONSerialization.data(withJSONObject: jsonObject, options: options)
        guard let value = String(data: data, encoding: .utf8) else { throw JSONSerializationError.invalidObject }
        return value
    }
}
