//
//  MoviesPopularEndpoints.swift
//  Movieland
//
//  Created by Dante Solorio on 29/04/21.
//

import Foundation

enum MoviesEndpoints: ServiceProtocol {
    
    case getMovies(page: Int, type: String)
    
    var baseURL: URL {
        return URL(string: NetworkConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case let .getMovies(_, type):
            return "/movie/\(type)"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self{
        case let .getMovies(page, _):
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
