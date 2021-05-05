//
//  Movie.swift
//  Movieland
//
//  Created by Dante Solorio on 29/04/21.
//

import Foundation

struct Movie: Codable, Hashable {
    
    var id: Int
    var posterPath: String?
    var originalTitle: String?
    var title: String?
    var voteAverage: Float?
    var overview: String?
    var releaseDate: String?
    var runtime: Int?
    
    var releaseYear: String {
        return getMovieReleaseYear(dateResult: releaseDate)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case originalTitle = "original_title"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
        case runtime
    }
    
    private func getMovieReleaseYear(dateResult: String?) -> String {
        let originalDateFormatter = DateFormatter()
        originalDateFormatter.dateFormat = "yyyy-MM-dd"
        guard let dateResult = dateResult else { return "" }
        let originalDate = originalDateFormatter.date(from: dateResult)

        let yearDateFormatter = DateFormatter()
        yearDateFormatter.dateFormat = "yyyy"
        guard let originalDate = originalDate else { return "" }
        return yearDateFormatter.string(from: originalDate)
    }

}
