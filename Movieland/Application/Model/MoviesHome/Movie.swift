//
//  Movie.swift
//  Movieland
//
//  Created by Dante Solorio on 29/04/21.
//

import Foundation

struct Movie: Codable, Hashable {
    
    var id: Int
    var posterPath: String
    var title: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case title
    }
}
