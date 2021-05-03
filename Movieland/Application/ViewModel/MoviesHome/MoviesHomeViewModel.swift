//
//  MoviesHomeViewModel.swift
//  Movieland
//
//  Created by Dante Solorio on 30/04/21.
//

import Foundation
import Combine

class MoviesHomeViewModel {
    
    private let session: URLSessionProvider
    
    var popularMoviesSubject = PassthroughSubject<Popular?, Error>()
    
    init(session: URLSessionProvider) {
        self.session = session
    }
    
    func getPopularMovies(page: Int = 1) {
        let popularMoviesEndpoint = MoviesPopularEndpoints.popular(page: page)
        session.request(type: Popular.self, service: popularMoviesEndpoint) { [weak self] response in
            switch response {
            case .success(let popularMoviesResult):
                self?.popularMoviesSubject.send(popularMoviesResult)
            case let .failure(error):
                self?.popularMoviesSubject.send(completion: .failure(error))
            }
        }
    }
}
