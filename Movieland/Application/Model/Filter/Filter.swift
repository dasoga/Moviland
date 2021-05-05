//
//  Filter.swift
//  Movieland
//
//  Created by Dante Solorio on 05/05/21.
//

import Foundation

enum Filter {
    case popular
    case topRated
    
    var description: String {
        switch self {
        case .popular:
            return "Popular"
        case .topRated:
            return "Top Rated"
        }
    }
}
