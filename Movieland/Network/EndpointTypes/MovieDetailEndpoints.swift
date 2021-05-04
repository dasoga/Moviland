//
//  MovieDetailEndpoints.swift
//  Movieland
//
//  Created by Dante Solorio on 04/05/21.
//

import Foundation

enum MovieDetailEndpoints: ServiceProtocol {
    
    case getTrailers(movieId: Int)
    
    var baseURL: URL {
        return URL(string: NetworkConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case let .getTrailers(movieId):
            return "/movie/\(movieId)/videos"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self{
        case .getTrailers(_):
            var parameters: Parameters = [:]
            parameters[NetworkConstants.APIKeyParameter] = NetworkConstants.APIKey
            return .requestParameters(parameters)
        }
    }
    
    var parametersEncoding: ParameterEncodingEnum {
        return .urlEncoding
    }
    
}
