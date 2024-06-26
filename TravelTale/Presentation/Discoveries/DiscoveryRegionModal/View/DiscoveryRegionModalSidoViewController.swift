//
//  DiscoveryRegionModalSidoViewController.swift
//  TravelTale
//
//  Created by 배지해 on 6/12/24.
//

import UIKit

final class DiscoveryRegionModalSidoViewController: BaseViewController {
    
    // MARK: - properties
    private let regionView = RegionView()
    
    private let networkManager = NetworkManager.shared
    
    private var sidoData: [Sido] = []
    
    var completion: ((Sido) -> Void)?
    
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
    
    func configureSidoView() {
        regionView.bind(text: "시/도 선택")
        requestSidos()
    }
    
    private func requestSidos() {
        networkManager.fetchSidos { result in
            switch result {
            case .success(let sidos):
                guard let sidoData = sidos.sidos else { return }
                self.sidoData = sidoData
                self.regionView.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - extentions
extension DiscoveryRegionModalSidoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        completion?(sidoData[indexPath.row])
        dismiss(animated: true)
    }
}

extension DiscoveryRegionModalSidoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sidoData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RegionTableViewCell.identifier, for: indexPath) as? RegionTableViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        cell.bind(text: sidoData[indexPath.row].name ?? "")
        
        return cell
    }
}
