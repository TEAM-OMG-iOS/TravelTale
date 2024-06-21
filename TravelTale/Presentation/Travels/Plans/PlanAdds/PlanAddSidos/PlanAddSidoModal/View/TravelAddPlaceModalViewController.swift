//
//  TravelAddPlaceModalViewController.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/11/24.
//

import UIKit

final class TravelAddPlaceModalViewController: BaseViewController {
    
    // MARK: - properties
    private let locationView = RegionView()
    
    private let locations: [String] = ["서울특별시", "인천광역시", "부산광역시",
                                       "대전광역시", "대구광역시", "울산광역시",
                                       "광주광역시", "제주특별자치도", "세종특별자치시",
                                       "경기도", "강원도", "충청북도", "충청남도",
                                       "경상북도", "경상남도", "전라북도", "전라남도"]
    
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
        
        locationView.tableView.register(RegionTableViewCell.self,
                                        forCellReuseIdentifier: RegionTableViewCell.identifier)
    }
}

// MARK: - extensions
extension TravelAddPlaceModalViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RegionTableViewCell.identifier, for: indexPath) as? RegionTableViewCell else { return UITableViewCell() }
        
        cell.bind(text: locations[indexPath.row])
        locationView.bind(text: "대표 여행 장소를 선택해주세요")
        
        
        return cell
    }
}

extension TravelAddPlaceModalViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? RegionTableViewCell else { return }
        cell.setSelected(true, animated: true)
        
        completion?(locations[indexPath.row])
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? RegionTableViewCell else { return }
        cell.setSelected(false, animated: false)
    }
}