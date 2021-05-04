//
//  Popular.swift
//  Movieland
//
//  Created by Dante Solorio on 29/04/21.
//

import Foundation

struct Popular: Codable {
    var page: Int
    var results: [Movie]
    var totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalResults = "total_results"        
    }
}
