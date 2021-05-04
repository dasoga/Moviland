//
//  VideosResult.swift
//  Movieland
//
//  Created by Dante Solorio on 04/05/21.
//

import Foundation

struct VideosResult: Codable {
    var id: Int
    var results: [Video]
}
