//
//  MoveDetailServices.swift
//  Movieland
//
//  Created by Dante Solorio on 04/05/21.
//

import Foundation

class MovieDetailServices {
    
    let session = URLSessionProvider()
    
    func getMovieTrailers(movieID: Int, _ completion: @escaping ([Video], String?) -> Void) {
        let movieTrailersEndpoint = MovieDetailEndpoints.getTrailers(movieId: movieID) 
        session.request(type: VideosResult.self, service: movieTrailersEndpoint) { response in
            switch response {
            case .success(let movieTrailersResponse):
                completion((movieTrailersResponse?.results ?? []), nil)
            case let .failure(error):
                // TODO: Manage errors                
                completion([], error.localizedDescription)
            }
        }
    }
}
