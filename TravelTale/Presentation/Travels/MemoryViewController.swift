//
//  TravelMemoryViewController.swift
//  TravelTale
//
//  Created by 유림 on 6/8/24.
//

import UIKit

final class MemoryViewController: BaseViewController {
    
    // MARK: - properties
    private let memoryView = MemoryView()
    private var travels: [Travel] = [] {
        didSet {
            memoryView.showNotFoundView(travels.isEmpty)
            memoryView.tableView.reloadData()
        }
    }
    
    // MARK: - life cycles
    override func loadView() {
        view = memoryView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        travels = RealmManager.shared.fetchMemories()
    }
    
    // MARK: - methods
    override func configureStyle() {
        memoryView.tableView.separatorStyle = .none
    }
    
    override func configureDelegate() {
        memoryView.tableView.dataSource = self
        memoryView.tableView.delegate = self
        memoryView.tableView.register(TravelTableViewCell.self, forCellReuseIdentifier: TravelTableViewCell.identifier)
    }
    
    override func configureAddTarget() {
        memoryView.addButtonView.button.addTarget(self, action: #selector(tappedAddButton), for: .touchUpInside)
    }
    
    @objc func tappedAddButton() {
        let nextVC = MemorySelectViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

// MARK: - extensions
extension MemoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TravelTableViewCell.identifier, for: indexPath) as? TravelTableViewCell else { return UITableViewCell() }
        
        cell.bind(travel: travels[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
}

extension MemoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = MemoryDetailViewController(travel: travels[indexPath.row])
        navigationController?.pushViewController(nextVC, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
