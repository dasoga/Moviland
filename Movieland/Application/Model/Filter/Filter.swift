//
//  Filter.swift
//  Movieland
//
//  Created by Dante Solorio on 05/05/21.
//

import Foundation

enum Filter: Int, CaseIterable {
    case popular
    case topRated
    
    var description: String {
        switch self {
        case .popular:
            return .popular
        case .topRated:
            return .topRated
        }
    }
    
    var isSelected: Bool {
        return UserDefaultsManager.filterSelected == self.rawValue
    }
    
    var type: String {
        switch self {
        case .popular:
            return "popular"
        case .topRated:
            return "top_rated"
        }
    }
}
