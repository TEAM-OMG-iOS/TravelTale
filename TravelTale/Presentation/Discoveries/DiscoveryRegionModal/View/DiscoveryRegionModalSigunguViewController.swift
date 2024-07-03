//
//  DiscoveryRegionModalSigunguViewController.swift
//  TravelTale
//
//  Created by 배지해 on 6/21/24.
//

import UIKit

final class DiscoveryRegionModalSigunguViewController: BaseViewController {
    
    // MARK: - properties
    private let regionView = RegionView()
    
    private let networkManager = NetworkManager.shared
    
    private var sidoCode: String = ""
    private var sigunguData: [Sigungu] = []
    
    var completion: ((Sigungu) -> Void)?
    
    // MARK: - life cycles
    override func loadView() {
        view = regionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - methods
    override func configureDelegate() {
        regionView.tableView.dataSource = self
        regionView.tableView.delegate = self
        
        regionView.tableView.register(RegionTableViewCell.self, forCellReuseIdentifier: RegionTableViewCell.identifier)
    }
    
    func configureSigunguView() {
        regionView.bind(text: "시/군/구 선택")
        requestSigungus()
    }
    
    func setSidoCode(sidoCode: String) {
        self.sidoCode = sidoCode
    }
    
    private func requestSigungus() {
        networkManager.fetchSigungus(sidoCode: sidoCode) { result in
            switch result {
            case .success(let sigungus):
                guard let sigunguData = sigungus.sigungus else { return }
                self.sigunguData = sigunguData
                self.regionView.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - extentions
extension DiscoveryRegionModalSigunguViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        completion?(sigunguData[indexPath.row])
        dismiss(animated: true)
    }
}

extension DiscoveryRegionModalSigunguViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sigunguData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RegionTableViewCell.identifier, for: indexPath) as? RegionTableViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        cell.bind(text: sigunguData[indexPath.row].name ?? "")
        
        return cell
    }
}
