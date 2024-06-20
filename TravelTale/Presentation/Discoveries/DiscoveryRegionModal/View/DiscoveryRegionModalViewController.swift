//
//  DiscoveryRegionModalViewController.swift
//  TravelTale
//
//  Created by 배지해 on 6/12/24.
//

import UIKit

final class DiscoveryRegionModalViewController: BaseViewController {
    
    // MARK: - properties
    private let locationView = LocationView()
    
    private var regionData: [String] = []
    
    var completion: ((String) -> Void)?
    
    // MARK: - life cycles
    override func loadView() {
        view = locationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - methods
    override func configureDelegate() {
        locationView.tableView.dataSource = self
        locationView.tableView.delegate = self
        
        locationView.tableView.register(LocationTableViewCell.self, forCellReuseIdentifier: LocationTableViewCell.identifier)
    }
    
    func bind(isCity: Bool, city: String = "서울특별시") {
        if isCity {
            // To do - 시/도 선택 바인딩
            locationView.bind(text: "시/도 선택")
        } else {
            // To do - 시/군/구 선택 바인딩
            locationView.bind(text: "시/군/구 선택")
        }
    }
}

// MARK: - extentions
extension DiscoveryRegionModalViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        completion?(regionData[indexPath.row])
        
        dismiss(animated: true)
    }
}

extension DiscoveryRegionModalViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return regionData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.identifier, for: indexPath) as? LocationTableViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        cell.bind(text: regionData[indexPath.row])
        
        return cell
    }
}
