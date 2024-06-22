//
//  PlanAddSidoModalViewController.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/11/24.
//

import UIKit

final class PlanAddSidoModalViewController: BaseViewController {
    
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
        
        regionView.tableView.register(RegionTableViewCell.self,
                                      forCellReuseIdentifier: RegionTableViewCell.identifier)
    }
    
    func configureSidoView() {
        regionView.bind(text: "대표 여행 장소를 선택해주세요")
        requestSido()
    }
    
    func requestSido() {
        networkManager.fetchSidos { result in
            switch result {
            case .success(let sidos):
                guard let sidoData = sidos.sidos else { return }
                self.sidoData = sidoData
                self.regionView.tableView.reloadData()
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
}

// MARK: - extensions
extension PlanAddSidoModalViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sidoData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RegionTableViewCell.identifier, for: indexPath) as? RegionTableViewCell else { return UITableViewCell() }
        
        cell.bind(text: sidoData[indexPath.row].name ?? "")
        
        return cell
    }
}

extension PlanAddSidoModalViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? RegionTableViewCell else { return }
        cell.setSelected(true, animated: true)
        
        completion?(sidoData[indexPath.row])
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? RegionTableViewCell else { return }
        cell.setSelected(false, animated: false)
    }
}
