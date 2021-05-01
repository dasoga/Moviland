//
//  MoviesHomeViewController.swift
//  Movieland
//
//  Created by Dante Solorio on 29/04/21.
//

import UIKit
import Combine

class MoviesHomeViewController: UIViewController {
    
    // MARK: - Private properties
    
    private lazy var moviesHomeView = MoviesHomeView(frame: view.frame)
    var homeViewModel = MoviesHomeViewModel(session: URLSessionProvider())
    
    // Subscritions to receive the popular movies list
    var subscription: AnyCancellable?

    let session = URLSessionProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
        homeViewModel.getPopularMovies()
    }
    
    // MARK: - Private functions
    
    private func setupView() {
        view.addSubview(moviesHomeView)
    }
    
    private func setupBindings() {
        subscription = homeViewModel.popularMoviesSubject.sink(receiveCompletion: { completion in
            switch completion {
            case let .failure(error):
                // TODO: Manage error getting popular movies list
                print("Error: \(error.localizedDescription)")
            default: break
            }
        }, receiveValue: { [weak self] movies in
            self?.moviesHomeView.movies = movies
        })
    }
}
