//
//  TravelAddLocationViewController.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/11/24.
//

import UIKit

final class TravelAddLocationViewController: BaseViewController {
    
    // MARK: - properties
    private let travelAddLocationView = TravelAddLocationView()
    
    var locations: [String] = ["서울특별시", "인천광역시", "부산광역시",
                               "대전광역시", "대구광역시", "울산광역시",
                               "광주광역시", "제주특별자치도", "세종특별자치시",
                               "경기도", "강원도", "충청북도", "충청남도",
                               "경상북도", "경상남도", "전라북도", "전라남도"]
    
    var completion: ((String) -> Void)?
    
    // MARK: - lifecycle
    override func loadView() {
        view = travelAddLocationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - methods
    override func configureStyle() {
        travelAddLocationView.tableView.reloadData()
    }
    
    override func configureDelegate() {
        travelAddLocationView.tableView.dataSource = self
        travelAddLocationView.tableView.delegate = self
        
        travelAddLocationView.tableView.register(TravelLocationTableViewCell.self,
                                                 forCellReuseIdentifier: TravelLocationTableViewCell.identifier)
    }
}

// MARK: - extensions
extension TravelAddLocationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TravelLocationTableViewCell.identifier, for: indexPath) as? TravelLocationTableViewCell else { return TravelLocationTableViewCell() }
        cell.locationLabel.text = locations[indexPath.row]
        
        return cell
    }
}

extension TravelAddLocationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? TravelLocationTableViewCell else { return }
        cell.selectLocation(true)
        
        completion?(locations[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? TravelLocationTableViewCell else { return }
        cell.selectLocation(false)
    }
}
