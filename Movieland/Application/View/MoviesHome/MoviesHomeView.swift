//
//  MoviesHomeView.swift
//  Movieland
//
//  Created by Dante Solorio on 30/04/21.
//

import UIKit

protocol MoviesViewDelegate {
    func fetchMoreMovies()
    func goMovieDetailView(_ movie: Movie)
}

private enum Section: CaseIterable {
    case main
}

class MoviesHomeView: UIView {
    
    // MARK: - Internal properties
    
    var movies: [Movie] = [] {
        didSet {
            if movies.count > 0 {
                applySnapshot()
            } else {
              // TODO: Show empty list view
            }
        }
    }
    
    var totalResults = 0
    
    // MARK: - Private properties
    
    private lazy var moviesCollectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private lazy var compositionalLayout: UICollectionViewCompositionalLayout = {
        let inset: CGFloat = 10
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/4)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }()
    
    private lazy var dataSource = makeDataSource()
    
    var delegate: MoviesViewDelegate?
    
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
        let dataSource = UICollectionViewDiffableDataSource<Section, Movie>(collectionView: moviesCollectionView) { (collectionView, indexPath, movie) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Home.moviesCell, for: indexPath) as! PopularMoviesCollectionViewCell
            cell.movie = movie
            return cell
        }
        
        return dataSource
    }
    
    private func registerCollectionViewClass() {
        moviesCollectionView.dataSource = dataSource
        moviesCollectionView.register(PopularMoviesCollectionViewCell.self, forCellWithReuseIdentifier: Constants.Home.moviesCell)
    }
    
    private func setupView() {
        moviesCollectionView.delegate = self
        
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(moviesCollectionView)
        moviesCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        moviesCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        moviesCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        moviesCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

extension MoviesHomeView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == movies.count - 1 && movies.count < totalResults {
            delegate?.fetchMoreMovies()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.goMovieDetailView(movies[indexPath.item])
    }
}
