//
//  MovieDetailViewController.swift
//  Movieland
//
//  Created by Dante Solorio on 04/05/21.
//

import UIKit
import Combine

class MovieDetailViewController: UIViewController {
    
    private lazy var moviesDetailView = MovieDetailView(frame: view.frame)
    var movieDetailViewModel = MovieDetailViewModel(session: URLSessionProvider())
    
    var movie: Movie?
    
    // Subscritions to receive the popular movies list
    var subscription: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        moviesDetailView.delegate = self
        moviesDetailView.movie = movie
        view.addSubview(moviesDetailView)
    }
    
    private func setupBindings() {
        subscription = movieDetailViewModel.movieTrailersSubject.sink(receiveCompletion: { completion in
            switch completion {
            case let .failure(error):
                // TODO: Manage error getting popular movies list
                print("Error: \(error.localizedDescription)")
            default: break
            }
        }, receiveValue: { [weak self] videos in
            self?.moviesDetailView.videos.append(contentsOf: videos)
        })
    }
}


extension MovieDetailViewController: MovieDetailViewDelegate {
    func getMovieTrailers(movieID: Int) {
        movieDetailViewModel.getMovieTrailer(movieID: movieID)
    }
}
