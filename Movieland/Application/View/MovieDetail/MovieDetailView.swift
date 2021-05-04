//
//  MovieDetailView.swift
//  Movieland
//
//  Created by Dante Solorio on 04/05/21.
//

import UIKit

class MovieDetailView: UIView {
    
    // MARK: - Properties
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

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
    }
}
