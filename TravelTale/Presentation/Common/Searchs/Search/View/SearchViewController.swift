//
//  SearchViewController.swift
//  TravelTale
//
//  Created by 김정호 on 6/21/24.
//

import UIKit

final class SearchViewController: BaseViewController {
    
    // MARK: - properties
    private let searchView = SearchView()
    
    // MARK: - life cycles
    override func loadView() {
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - methods
    override func configureStyle() {
        configureNavigation()
    }
    
    override func configureDelegate() {
        searchView.searchBar.delegate = self
        
        searchView.tableView.delegate = self
        searchView.tableView.dataSource = self
        
        searchView.tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
    }
    
    override func configureAddTarget() {
        searchView.backBarButtonItem.target = self
        searchView.backBarButtonItem.action = #selector(tappedBackBarButtonItem)
    }
    
    private func configureNavigation() {
        navigationItem.titleView = searchView.titleLabel
        navigationItem.leftBarButtonItem = searchView.backBarButtonItem
    }
    
    @objc private func tappedBackBarButtonItem() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - extensions
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchResultVC = SearchResultViewController()
        searchResultVC.searchText = searchBar.text
        searchBar.resignFirstResponder()
        
        navigationController?.pushViewController(searchResultVC, animated: true)
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchResultVC = SearchResultViewController()
        searchResultVC.searchText = "임시 데이터"
        
        navigationController?.pushViewController(searchResultVC, animated: true)
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        
        return cell
    }
}
