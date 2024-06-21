//
//  TravelMemoryViewController.swift
//  TravelTale
//
//  Created by 유림 on 6/8/24.
//

import UIKit

final class TravelMemoryViewController: BaseViewController {
    
    // MARK: - properties
    private let memoryView = MemoryView()
    private var travels: [Travel] = [] {
        didSet {
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
        let travelMemoryAddVC = TravelMemoryAddViewController()
        self.navigationController?.pushViewController(travelMemoryAddVC, animated: true)
    }
}

// MARK: - extensions
extension TravelMemoryViewController: UITableViewDataSource {
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

extension TravelMemoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = TravelMemoryDetailViewController(travel: travels[indexPath.row])
        navigationController?.pushViewController(nextVC, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
