//
//  NetworkError.swift
//  Movieland
//
//  Created by Dante Solorio on 29/04/21.
//

import Foundation

enum NetworkError: String, Error {
    case unknown = "Unknown error"
    case noJSONData = "Response is not a valid JSON data"
    case errorJSONData = "Error getting JSON data"
    case missingURL = "URL is nil."
}
