//
//  URLComponentsExtension.swift
//  Movieland
//
//  Created by Dante Solorio on 29/04/21.
//

import Foundation

extension URLComponents {
    
    init(service: ServiceProtocol) {
        self.init(url: service.baseURL.appendingPathComponent(service.path), resolvingAgainstBaseURL: false)!
        
        guard case let .requestParameters(parameters) = service.task, service.parametersEncoding == .urlEncoding else { return }
        
        queryItems = parameters.map { key, value in
            return URLQueryItem(name: key, value: String(describing: value).replacingOccurrences(of: "+", with: "%2B"))
        }
    }
}
