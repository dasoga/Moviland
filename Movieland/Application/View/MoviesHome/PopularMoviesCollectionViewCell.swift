//
//  PopularMoviesCollectionViewCell.swift
//  Movieland
//
//  Created by Dante Solorio on 01/05/21.
//

import UIKit

class PopularMoviesCollectionViewCell: UICollectionViewCell {
    
    let posterImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "MoviePlaceholder"))
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell(frame: CGRect) {
        
        // Use porcentage for screen sizes
        /*
        let width = frame.width
        let height = frame.height
        let leftRightMargin = width * 0.05
        let topBottomMargin = height * 0.1
        let imageViewSize = height * 0.6
        */
        
        contentView.layer.cornerRadius = 8
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = .zero
        contentView.layer.shadowOpacity = 0.2
        
        addSubview(posterImageView)
        posterImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        posterImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        posterImageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
