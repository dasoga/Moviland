//
//  MovieDetailViewController.swift
//  Movieland
//
//  Created by Dante Solorio on 04/05/21.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    private lazy var moviesDetailView = MovieDetailView(frame: view.frame)
    
    var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(moviesDetailView)
    }

}
