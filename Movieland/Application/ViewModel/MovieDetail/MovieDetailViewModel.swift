//
//  MovieDetailViewModel.swift
//  Movieland
//
//  Created by Dante Solorio on 04/05/21.
//

import Foundation
import Combine

class MovieDetailViewModel {
    
    private lazy var movieDetailService = MovieDetailServices()
    private let session: URLSessionProvider
    
    var movieTrailersSubject = PassthroughSubject<[Video], Error>()
    
    init(session: URLSessionProvider) {
        self.session = session
    }
    
    func getMovieTrailer(movieID: Int) {
        movieDetailService.getMovieTrailers(movieID: movieID) { [weak self] videos, error in
            if let error = error {
                print(error)
                return
            }
            
            // Got videos without errors
            if videos.count > 0 {
                self?.movieTrailersSubject.send(videos)
            }
        }
    }    
}
