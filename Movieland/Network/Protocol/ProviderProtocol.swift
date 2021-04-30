//
//  ProviderProtocol.swift
//  Movieland
//
//  Created by Dante Solorio on 29/04/21.
//

import Foundation

protocol ProviderProtocol {
    func request<T>(type: T.Type, service: ServiceProtocol, completion: @escaping (NetworkResponse<T>) -> ()) where T: Decodable
}
