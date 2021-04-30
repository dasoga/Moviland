//
//  URLRequestExtension.swift
//  Movieland
//
//  Created by Dante Solorio on 29/04/21.
//

import Foundation

extension URLRequest {

    init(service: ServiceProtocol) {
        self.init(url: URLComponents(service: service).url!)
    }
}
