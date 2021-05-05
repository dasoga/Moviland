//
//  FilterMoviesViewController.swift
//  Movieland
//
//  Created by Dante Solorio on 05/05/21.
//

import UIKit

protocol FilterMoviesViewControllerDelegate {
    func filterSelected(filter: Filter)
}

class FilterMoviesViewController: UIViewController {
    
    var delegate: FilterMoviesViewControllerDelegate?
    
    private lazy var filterTableView: UITableView = {
        let tv = UITableView(frame: .zero)
        tv.backgroundColor = .clear
        tv.dataSource = self
        tv.delegate = self
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    var filters: [Filter] = [.popular, .topRated]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Private functions
    
    private func setupView() {
        title = .filters
        view.backgroundColor = .systemBackground
        
        // Register filter cell
        filterTableView.register(UITableViewCell.self, forCellReuseIdentifier: "filterCell")
        
        view.addSubview(filterTableView)
        
        NSLayoutConstraint.activate([
            filterTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            filterTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            filterTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            filterTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

extension FilterMoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell")!
        let currentFilter = filters[indexPath.row]
        cell.textLabel?.text = currentFilter.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters.count
    }
}


extension FilterMoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.filterSelected(filter: filters[indexPath.item])
        dismiss(animated: true)
    }
}
