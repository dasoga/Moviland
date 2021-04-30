//
//  URLSessionExtension.swift
//  Movieland
//
//  Created by Dante Solorio on 29/04/21.
//

import Foundation

extension URLSession: URLSessionProtocol {
    
    func dataTask(request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask {
        return dataTask(with: request, completionHandler: completionHandler)
    }
}
