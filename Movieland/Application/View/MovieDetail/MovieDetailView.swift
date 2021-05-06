//
//  MovieDetailView.swift
//  Movieland
//
//  Created by Dante Solorio on 04/05/21.
//

import Combine
import UIKit

protocol MovieDetailViewDelegate {
    func getMovieTrailers(movieID: Int)
}

class MovieDetailView: UIView {
    
    // MARK: - Properties
    
    private let posterImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "video")?.withRenderingMode(.alwaysTemplate))
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.tintColor = .lightGray
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let ratingLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14, weight: .light)
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let releaseDateLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14, weight: .light)
        lbl.textAlignment = .right
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 20, weight: .semibold)
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let synopsisTextView: UITextView = {
        let tv = UITextView()
        tv.textAlignment = .center
        tv.isEditable = false        
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private let trailerButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .systemBlue
        btn.isHidden = true
        btn.setTitle("Trailer 1", for: .normal)
        btn.addTarget(self, action: #selector(showTrailer), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private var cache = ImageCache.shared
    private var delegate: MovieDetailViewDelegate?
    private var subscription: AnyCancellable?
    
    var movie: Movie? {
        didSet {
            setMovieInformation()
            getMovieTrailers()
            getMoviePoster()
        }
    }
    
    var videos: [Video] = [] {
        didSet {
            // TODO: Replace this with a table for more than one trailer
            showTrailersUI()
        }
    }

    // MARK: - Initializers
    
    convenience init(frame: CGRect, delegate: MovieDetailViewDelegate?) {
        self.init(frame: frame)
        self.delegate = delegate
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions
    
    private func setMovieInformation() {
        if let voteAverage = movie?.voteAverage {
            ratingLabel.text = .rating + ": " + String(format: "%.2f / 10", voteAverage)
        }
        
        releaseDateLabel.text = movie?.releaseYear
        titleLabel.text = movie?.originalTitle
        synopsisTextView.text = movie?.overview
    }

    private func setupView() {
        let width = frame.width
        let height = frame.height
        let horizontalMargin = width * 0.05
        let verticalMargin = height * 0.05
        let smallHorizontalMargin = horizontalMargin * 0.5
        let smallVerticalMargin = verticalMargin * 0.5
        let posterImageViewHeightMultiplier: CGFloat = 0.5
        let trailerButtonWidthMultiplier: CGFloat = 0.9
        
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(posterImageView)
        posterImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        posterImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        posterImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        posterImageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: posterImageViewHeightMultiplier).isActive = true
        
        addSubview(ratingLabel)
        ratingLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: smallVerticalMargin).isActive = true
        ratingLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: smallHorizontalMargin).isActive = true
        ratingLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        addSubview(releaseDateLabel)
        releaseDateLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: smallVerticalMargin).isActive = true
        releaseDateLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        releaseDateLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -smallHorizontalMargin).isActive = true
        
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: verticalMargin).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: horizontalMargin).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -horizontalMargin).isActive = true
        
        addSubview(trailerButton)
        trailerButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -verticalMargin).isActive = true
        trailerButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        trailerButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: trailerButtonWidthMultiplier).isActive = true
        trailerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        addSubview(synopsisTextView)
        synopsisTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: verticalMargin).isActive = true
        synopsisTextView.bottomAnchor.constraint(equalTo: trailerButton.topAnchor, constant: -verticalMargin).isActive = true
        synopsisTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: horizontalMargin).isActive = true
        synopsisTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -horizontalMargin).isActive = true
    }
    
    private func getMovieTrailers() {
        guard let id = movie?.id else { return }
        delegate?.getMovieTrailers(movieID: id)
    }
    
    private func getMoviePoster() {
        guard let posterPath = movie?.posterPath else { return }
        guard let url = URL(string: "\(NetworkConstants.imageBaseURL)\(NetworkConstants.w780Size)\(posterPath)") else { return }
        
        if let image = cache[url.absoluteString] {
            posterImageView.image = image
            return
        }
        
        subscription = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .handleEvents(receiveOutput: {
                self.cache[url.absoluteString] = $0
            })
            .receive(on: DispatchQueue.main)
            .assign(to: \.posterImageView.image, on: self)
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
