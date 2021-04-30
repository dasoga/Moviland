//
//  NetworkResponse.swift
//  Movieland
//
//  Created by Dante Solorio on 29/04/21.
//

import Foundation

enum NetworkResponse<T> {
    case success(T?)
    case failure(NetworkError)
}
