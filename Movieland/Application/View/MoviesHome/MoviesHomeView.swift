//
//  MoviesHomeView.swift
//  Movieland
//
//  Created by Dante Solorio on 30/04/21.
//

import UIKit

private enum Section: CaseIterable {
    case main
}

class MoviesHomeView: UIView {
    
    // MARK: - Internal properties
    
    var movies: [Movie] = [] {
        didSet {
            applySnapshot()
        }
    }
    
    // MARK: - Private properties
    
    private lazy var moviesCollectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private lazy var compositionalLayout: UICollectionViewCompositionalLayout = {
        let inset: CGFloat = 10
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset * 2, bottom: inset, trailing: inset * 2)
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }()
    
    private lazy var dataSource = makeDataSource()
    
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        registerCollectionViewClass()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions
    
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(movies)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func makeDataSource() -> UICollectionViewDiffableDataSource<Section, Movie> {
        let dataSource = UICollectionViewDiffableDataSource<Section, Movie>(collectionView: moviesCollectionView) { (collectionView, indexPath, vendingMachine) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath)
            return cell
        }
        
        return dataSource
    }
    
    private func registerCollectionViewClass() {
        moviesCollectionView.dataSource = dataSource
    }
    
    private func setupView() {
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(moviesCollectionView)
        moviesCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        moviesCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        moviesCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        moviesCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
