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
        homeViewModel.getMovies()
    }
    
    // MARK: - Private functions
    
    private func setupView() {
        title = Filter.allCases.first(where: { $0.isSelected })?.description.capitalized
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(moviesHomeView)
        
        // Show filter button
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .actions, style: .plain, target: self, action: #selector(handleActionsBarButton))
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
    
    // MARK: - Actions
    
    @objc private func handleActionsBarButton(_ sender: UIBarButtonItem) {
        let filterController = FilterMoviesViewController()
        filterController.delegate = self
        navigationController?.present(UINavigationController(rootViewController: filterController), animated: true)
    }
}

extension MoviesHomeViewController: MoviesViewDelegate {
    func fetchMoreMovies() {
        // Fetch more data with pagination
        currentPage += 1
        print("Fetch more data, page: \(currentPage)")
        moviesHomeView.showActivityIndicatorView()
        homeViewModel.getMovies(page: currentPage)
    }
    
    func goMovieDetailView(_ movie: Movie) {
        // Go to movie detail view
        let movieDetailController = MovieDetailViewController()
        movieDetailController.movie = movie
        navigationController?.pushViewController(movieDetailController, animated: true)
    }
}

// MARK: - FilterMoviesViewControllerDelegate

extension MoviesHomeViewController: FilterMoviesViewControllerDelegate {
    func filterSelected(filter: Filter) {
        if filter.rawValue != UserDefaultsManager.filterSelected {
            UserDefaultsManager.filterSelected = filter.rawValue
            currentPage = 1
            moviesHomeView.movies.removeAll()
            homeViewModel.getMovies()
            title = filter.description
        }
    }
}
