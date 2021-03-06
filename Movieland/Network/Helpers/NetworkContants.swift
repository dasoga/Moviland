//
//  NetworkContants.swift
//  Movieland
//
//  Created by Dante Solorio on 29/04/21.
//

import Foundation

struct NetworkConstants {
    
    static let baseURL = "https://api.themoviedb.org/3"
    static let imageBaseURL = "https://image.tmdb.org/t/p/"
    static let APIKey = "914c7cee308e33b79a6cb098f027cddd"
    static let APIKeyParameter = "api_key"
    static let w185Size = "w185"
    static let w500Size = "w500"
    static let w780Size = "w780"
    static let page = "page"
    
    // Validate valid response codes
    static func isSuccessStatusCode(statusCode: (Int)) -> Bool {
        return (statusCode >= 200) && (statusCode < 300)
    }
    
    static let unauthorizedStatusCode = 401
}
