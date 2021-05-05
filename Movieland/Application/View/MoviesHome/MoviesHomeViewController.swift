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
    
    private lazy var moviesHomeView = MoviesHomeView(frame: view.frame, delegate: self)
    var homeViewModel = MoviesHomeViewModel(session: URLSessionProvider())
    
    // Subscritions to receive the popular movies list
    var subscription: AnyCancellable?

    let session = URLSessionProvider()
    var currentPage = 1    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
        moviesHomeView.showActivityIndicatorView()
        homeViewModel.getPopularMovies()
    }
    
    // MARK: - Private functions
    
    private func setupView() {
        title = Constants.Home.popularMovies
        navigationController?.navigationBar.prefersLargeTitles = true
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
        }, receiveValue: { [weak self] popularResult in
            self?.moviesHomeView.movies.append(contentsOf: popularResult?.results ?? [])
            self?.moviesHomeView.totalResults = popularResult?.totalResults ?? 0
            
            DispatchQueue.main.async {
                self?.moviesHomeView.hideActivityIndicatorView()
            }
        })
    }
}

extension MoviesHomeViewController: MoviesViewDelegate {
    func fetchMoreMovies() {
        // Fetch more data with pagination
        currentPage += 1
        print("Fetch more data, page: \(currentPage)")
        moviesHomeView.showActivityIndicatorView()
        homeViewModel.getPopularMovies(page: currentPage)
    }
    
    func goMovieDetailView(_ movie: Movie) {
        // Go to movie detail view
        let movieDetailController = MovieDetailViewController()
        movieDetailController.movie = movie
        navigationController?.pushViewController(movieDetailController, animated: true)
    }
}
