//
//  ServiceProtocol.swift
//  Movieland
//
//  Created by Dante Solorio on 29/04/21.
//

import Foundation

protocol ServiceProtocol {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: HTTPTask { get }
    var parametersEncoding: ParameterEncodingEnum { get }
}
