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

private enum LayoutType {
    case width
    case height
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
        let inset: CGFloat = 10.0
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(getLayoutSize(.width)), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 0.0, bottom: inset, trailing: 0.0)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(getLayoutSize(.height))), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }()
    
    private var activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        return aiv
    }()
    
    private var activityIndicatorViewHeightConstraint: NSLayoutConstraint?
    private var delegate: MoviesViewDelegate?
    
    private lazy var activityIndicatorSize = min(frame.width, frame.height) * 0.1
    private lazy var dataSource = makeDataSource()
    
    // MARK: - Initializers
    
    convenience init(frame: CGRect, delegate: MoviesViewDelegate?) {
        self.init(frame: frame)
        self.delegate = delegate
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        registerCollectionViewClass()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal functions
    
    func showActivityIndicatorView() {
        activityIndicatorView.startAnimating()
        
        guard !movies.isEmpty else {
            activityIndicatorView.style = .large
            return
        }
        
        activityIndicatorViewHeightConstraint?.constant = activityIndicatorSize
        activityIndicatorView.style = .medium
        activityIndicatorView.layoutIfNeeded()
    }
    
    func hideActivityIndicatorView() {
        activityIndicatorView.stopAnimating()
        activityIndicatorViewHeightConstraint?.isActive = false
        activityIndicatorViewHeightConstraint = activityIndicatorView.heightAnchor.constraint(equalToConstant: 0.0)
        activityIndicatorViewHeightConstraint?.isActive = true
        activityIndicatorView.layoutIfNeeded()
    }
    
    // MARK: - Private functions
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(movies)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func getLayoutSize(_ layoutType: LayoutType) -> CGFloat {
        let minimumWidth: CGFloat = UIScreen.main.bounds.width / (UIDevice.current.userInterfaceIdiom == .pad ? 5 : 3)
        let minimumHeight: CGFloat = UIScreen.main.bounds.height / (UIDevice.current.userInterfaceIdiom == .pad ? 3 : 4)
        
        switch layoutType {
        case .width:
            return 1/CGFloat(Int(UIScreen.main.bounds.width / minimumWidth))
        case .height:
            print(CGFloat(Int(UIScreen.main.bounds.height / minimumHeight)))
            return 1/CGFloat(Int(UIScreen.main.bounds.height / minimumHeight))
        }
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
        
        addSubview(activityIndicatorView)
        activityIndicatorViewHeightConstraint = activityIndicatorView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor)
        activityIndicatorViewHeightConstraint?.isActive = true
        activityIndicatorView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        activityIndicatorView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        addSubview(moviesCollectionView)
        moviesCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        moviesCollectionView.bottomAnchor.constraint(equalTo: activityIndicatorView.topAnchor).isActive = true
        moviesCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        moviesCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
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
