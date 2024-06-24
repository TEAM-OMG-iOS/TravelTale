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
    
    private let userDefaultsManager = UserDefaultsManager.shared
    
    private var keywords: [String] = []
    
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
        
        searchView.deleteAllButton.addTarget(self, action: #selector(tappedDeleteAllButton), for: .touchUpInside)
    }
    
    override func bind() {
        keywords = userDefaultsManager.fetchKeywords()
    }
    
    private func configureNavigation() {
        navigationItem.titleView = searchView.titleLabel
        navigationItem.leftBarButtonItem = searchView.backBarButtonItem
    }
    
    @objc private func tappedBackBarButtonItem() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func tappedDeleteAllButton() {
        keywords = userDefaultsManager.deleteAllKeywords()
        searchView.tableView.reloadData()
    }
    
    @objc private func tappedDeleteButton(sender: UIButton) {
        if let cell = sender.superview?.superview as? SearchTableViewCell, let indexPath = searchView.tableView.indexPath(for: cell) {
            keywords = userDefaultsManager.deleteKeyword(keyword: keywords[indexPath.row])
            searchView.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

// MARK: - extensions
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchResultVC = SearchResultViewController()
        
        searchResultVC.searchText = searchBar.text
        searchResultVC.completion = { [weak self] in
            guard let self = self else { return }
            
            keywords = userDefaultsManager.fetchKeywords()
            searchView.tableView.reloadData()
        }
        
        if let text = searchBar.text {
            keywords = userDefaultsManager.createKeyword(keyword: text)
            navigationController?.pushViewController(searchResultVC, animated: true)
        }
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchResultVC = SearchResultViewController()
        
        searchResultVC.searchText = keywords[indexPath.row]
        searchResultVC.completion = { [weak self] in
            guard let self = self else { return }
            
            keywords = userDefaultsManager.fetchKeywords()
            searchView.tableView.reloadData()
        }
        
        keywords = userDefaultsManager.createKeyword(keyword: keywords[indexPath.row])
        
        navigationController?.pushViewController(searchResultVC, animated: true)
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keywords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        cell.bind(keyword: keywords[indexPath.row])
        cell.deleteButton.addTarget(self, action: #selector(tappedDeleteButton), for: .touchUpInside)
        
        return cell
    }
}
