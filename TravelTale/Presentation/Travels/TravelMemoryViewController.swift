//
//  TravelMemoryViewController.swift
//  TravelTale
//
//  Created by 유림 on 6/8/24.
//

import UIKit

final class TravelMemoryViewController: BaseViewController {
    
    // MARK: - properties
    private let travelMemoryView = TravelMemoryView()
    private var travels: [Travel] = [] {
        didSet {
            travelMemoryView.tableView.reloadData()
        }
    }
    
    // MARK: - life cycles
    override func loadView() {
        view = travelMemoryView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        travels = RealmManager.shared.fetchMemories()
    }
    
    // MARK: - methods
    override func configureStyle() {
        travelMemoryView.tableView.separatorStyle = .none
    }
    
    override func configureDelegate() {
        travelMemoryView.tableView.dataSource = self
        travelMemoryView.tableView.delegate = self
        travelMemoryView.tableView.register(TravelTableViewCell.self, forCellReuseIdentifier: TravelTableViewCell.identifier)
    }
    
    override func configureAddTarget() {
        travelMemoryView.addButtonView.button.addTarget(self, action: #selector(tappedAddButton), for: .touchUpInside)
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
        
//        cell.bind(travel: travels[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
}

extension TravelMemoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = TravelMemoryDetailViewController(travelData: travels[indexPath.row])
        navigationController?.pushViewController(nextVC, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
