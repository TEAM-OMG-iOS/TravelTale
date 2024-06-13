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
    
    private var data: [String] = []
    
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
    
    func bind(isCity: Bool) {
        if isCity {
            data = RegionData().getCityData()
            locationView.bind(text: "시/도 선택")
        }else {
            data = RegionData().getRegionData(cityString: "대구광역시")
            locationView.bind(text: "구/군 선택")
        }
    }
}

// MARK: - extentions
extension DiscoveryRegionModalViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: 데이터 RegionVC으로 넘기기
        dismiss(animated: true)
    }
}

extension DiscoveryRegionModalViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: 데이터 생기면 넣기
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.identifier, for: indexPath) as? LocationTableViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        cell.bind(text: data[indexPath.row])
        
        return cell
    }
}
