//
//  MoviesHomeViewController.swift
//  Movieland
//
//  Created by Dante Solorio on 29/04/21.
//

import UIKit

class MoviesHomeViewController: UIViewController {
    
    // MARK: - Private properties
    
    private lazy var moviesHomeView = MoviesHomeView(frame: view.frame)

    let session = URLSessionProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
     
        let endpoint = MoviesPopularEndpoints.popular        
        session.request(type: Popular.self, service: endpoint) { response in
            switch response {
            case .success(let popularMovies):
                print(popularMovies?.results.count ?? 0)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    // MARK: - Private functions
    
    private func setupView() {
        view.addSubview(moviesHomeView)
    }
}
