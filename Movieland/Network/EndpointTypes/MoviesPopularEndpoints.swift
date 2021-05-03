//
//  MoviesPopularEndpoints.swift
//  Movieland
//
//  Created by Dante Solorio on 29/04/21.
//

import Foundation

enum MoviesPopularEndpoints: ServiceProtocol {
    
    case popular(page:Int)
    
    var baseURL: URL {
        return URL(string: NetworkConstants.baseURL)!
    }
    
    var path: String {
        return "/movie/popular"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self{
        case let .popular(page):
            var parameters: Parameters = [:]
            parameters[NetworkConstants.APIKeyParameter] = NetworkConstants.APIKey
            parameters[NetworkConstants.page] = page
            return .requestParameters(parameters)
        }
    }
    
    var parametersEncoding: ParameterEncodingEnum {
        return .urlEncoding
    }

    
}
