//
//  URLSessionProtocol.swift
//  Movieland
//
//  Created by Dante Solorio on 29/04/21.
//

import Foundation

protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> ()
    func dataTask(request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask
}
