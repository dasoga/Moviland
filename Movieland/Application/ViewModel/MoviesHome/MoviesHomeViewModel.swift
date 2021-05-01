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
    
    var popularMoviesSubject = PassthroughSubject<[Movie], Error>()
    
    init(session: URLSessionProvider) {
        self.session = session
    }
    
    func getPopularMovies() {
        let popularMoviesEndpoint = MoviesPopularEndpoints.popular
        session.request(type: Popular.self, service: popularMoviesEndpoint) { [weak self] response in
            switch response {
            case .success(let popularMovies):
                print(popularMovies?.results.count ?? 0)
                self?.popularMoviesSubject.send(popularMovies?.results ?? [])
            case let .failure(error):
                self?.popularMoviesSubject.send(completion: .failure(error))
            }
        }
    }
}
