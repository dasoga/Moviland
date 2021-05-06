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
    
    func getMovies(page: Int = 1, type: String? = Filter.allCases.first(where: { $0.isSelected })?.type) {
        guard let type = type else { return }
        let getMoviesEndpoint = MoviesEndpoints.getMovies(page: page, type: type)
        
        session.request(type: Popular.self, service: getMoviesEndpoint) { [weak self] response in
            switch response {
            case .success(let moviesResult):
                self?.popularMoviesSubject.send(moviesResult)
            case let .failure(error):
                self?.popularMoviesSubject.send(completion: .failure(error))
            }
        }
    }
}
