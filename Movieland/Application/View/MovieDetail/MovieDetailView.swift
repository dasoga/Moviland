//
//  MovieDetailView.swift
//  Movieland
//
//  Created by Dante Solorio on 04/05/21.
//

import UIKit

protocol MovieDetailViewDelegate {
    func getMovieTrailers(movieID: Int)
}

class MovieDetailView: UIView {
    
    // MARK: - Properties
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var trailerButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.setTitle("Trailer 1", for: .normal)
        button.addTarget(self, action: #selector(showTrailer), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var delegate: MovieDetailViewDelegate?
    
    var movie: Movie? {
        didSet {
            getMovieTrailers()
        }
    }
    var videos: [Video] = [] {
        didSet {
            // TODO: Replace this with a table for more than one trailer
            showTrailersUI()
        }
    }

    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions

    private func setupView() {
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let height = frame.height
        let titleHeight = height / 4
        
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 8).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: titleHeight).isActive = true
        
        addSubview(trailerButton)
        trailerButton.backgroundColor = .systemBlue
        trailerButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        trailerButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 16).isActive = true
        trailerButton.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: -16).isActive = true
        trailerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func getMovieTrailers() {
        guard let id = movie?.id else { return }
        delegate?.getMovieTrailers(movieID: id)
    }
    
    private func showTrailersUI() {
        DispatchQueue.main.async {
            self.trailerButton.isHidden = false
        }
    }
    
    // MARK: - Actions
    
    @objc func showTrailer() {
        // Show YouTube video
        let YoutubeID =  videos.first?.key ?? "" // Your Youtube ID here
        let appURL = URL(string: "youtube://www.youtube.com/watch?v=\(YoutubeID)")!
        let webURL = URL(string: "https://www.youtube.com/watch?v=\(YoutubeID)")!
        let application = UIApplication.shared

        if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
        } else {
            // if Youtube app is not installed, open URL inside Safari
            application.open(webURL as URL)
        }
    }
}
