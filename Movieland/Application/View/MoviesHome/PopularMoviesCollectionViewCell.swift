//
//  PopularMoviesCollectionViewCell.swift
//  Movieland
//
//  Created by Dante Solorio on 01/05/21.
//

import Combine
import UIKit

class PopularMoviesCollectionViewCell: UICollectionViewCell {
    
    var movie: Movie? {
        didSet {
            getPosterImage()
        }
    }
    
    private let posterImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "MoviePlaceholder"))
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 15.0
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private var cache = ImageCache.shared
    private var subscription: AnyCancellable?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getPosterImage() {
        guard let posterPath = movie?.posterPath else { return }
        guard let url = URL(string: "\(NetworkConstants.imageBaseURL)\(NetworkConstants.imageSize)\(posterPath)") else { return }
        
        if let image = cache[url.absoluteString] {
            posterImageView.image = image
            return
        }
        
        subscription = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: #imageLiteral(resourceName: "MoviePlaceholder"))
            .handleEvents(receiveOutput: {
                self.cache[url.absoluteString] = $0
            })
            .receive(on: DispatchQueue.main)
            .assign(to: \.posterImageView.image, on: self)
    }
    
    private func setupCell(frame: CGRect) {
        addSubview(posterImageView)
        posterImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        posterImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        posterImageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
