//
//  MovieDetailTests.swift
//  MovielandTests
//
//  Created by Dante Solorio on 05/05/21.
//

import XCTest
@testable import Movieland

class MovieDetailTests: XCTestCase {
    
    // Test with a correct date format
    func testGetMovieReleaseYear() {
        let movieModel = Movie(id: 1, posterPath: "", originalTitle: "", title: "", voteAverage: nil, overview: "", releaseDate: "2015-04-20", runtime: nil)
        XCTAssertEqual(movieModel.releaseYear, "2015")
    }
    
    // Test with bad format of date
    func testGetMovieReleaseYearBadFormat() {
        let movieModel = Movie(id: 1, posterPath: "", originalTitle: "", title: "", voteAverage: nil, overview: "", releaseDate: "2015-04-", runtime: nil)
        XCTAssertEqual(movieModel.releaseYear, "")
    }

}
