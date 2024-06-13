//
//  DiscoveryRegionModalViewController.swift
//  TravelTale
//
//  Created by 배지해 on 6/12/24.
//

import UIKit

final class DiscoveryRegionModalViewController: BaseViewController {
    
    // MARK: - properties
    private let discoveryRegionModalView = DiscoveryRegionModalView()
    
    private var data: [String] = []
    
    // MARK: - life cycles
    override func loadView() {
        view = discoveryRegionModalView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - methods
    override func configureDelegate() {
        discoveryRegionModalView.regionTableView.dataSource = self
        discoveryRegionModalView.regionTableView.delegate = self
        discoveryRegionModalView.regionTableView.register(DiscoveryRegionCell.self, forCellReuseIdentifier: DiscoveryRegionCell.identifier)
    }
    
    func bind(isCity: Bool) {
        if isCity {
            discoveryRegionModalView.bind(selectString: "시/도 선택")
        }else {
            discoveryRegionModalView.bind(selectString: "구/군 선택")
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DiscoveryRegionCell.identifier, for: indexPath) as? DiscoveryRegionCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        cell.bind(regionString: data[indexPath.row])
        
        return cell
    }
}
