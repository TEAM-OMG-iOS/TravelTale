//
//  TravelMemoryTravelSelectionViewController.swift
//  TravelTale
//
//  Created by 유림 on 6/10/24.
//

import UIKit
import RealmSwift // TODO: 삭제

final class MemorySelectViewController: BaseViewController {
    
    // MARK: - properties
    private let memorySelectView = MemorySelectView()
    
    private var noMemoryTravels: [Travel] = [] {
        didSet {
            memorySelectView.showNotFoundView(noMemoryTravels.isEmpty)
            memorySelectView.tableView.reloadData()
        }
    }
    
    private var selectedIndexPath: IndexPath?
    
    // MARK: - life cycles
    override func loadView() {
        view = memorySelectView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        
        noMemoryTravels = fetchNoMemoryTravels()
    }
    
    // MARK: - methods
    // TODO: RealmManager로 옮기기
    func fetchNoMemoryTravels() -> [Travel] {
        let realm = try! Realm()
        return realm.objects(Travel.self).filter {
            ($0.memory == nil) && ($0.photos.isEmpty)
        }
    }
    
    override func configureStyle() {
        configureNavigationBarItems()
        memorySelectView.tableView.separatorStyle = .none
    }
    
    override func configureDelegate() {
        memorySelectView.tableView.dataSource = self
        memorySelectView.tableView.delegate = self
        
        memorySelectView.tableView.register(TravelTableViewCell.self, forCellReuseIdentifier: TravelTableViewCell.identifier)
    }
    
    override func configureAddTarget() {
        memorySelectView.backButton.target = self
        memorySelectView.backButton.action = #selector(tappedBackButton)
        
        memorySelectView.confirmButton.addTarget(self, action: #selector(tappedConfirmButton), for: .touchUpInside)
    }
    
    private func configureNavigationBarItems() {
        navigationItem.title = "추억 남기기"
        navigationItem.leftBarButtonItem = memorySelectView.backButton
    }
    
    @objc func tappedBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func tappedConfirmButton() {
        if let selectedIndexPath = selectedIndexPath {
            let selectedTravel = noMemoryTravels[selectedIndexPath.row]
            let nextVC = MemoryAddEditViewController(travel: selectedTravel)
            navigationController?.pushViewController(nextVC, animated: true)
        } else {
            print("selectedIndexPath 없음")
        }
    }
}

// MARK: - extensions
extension MemorySelectViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noMemoryTravels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TravelTableViewCell.identifier) as? TravelTableViewCell else { return UITableViewCell() }
        
        let travel = noMemoryTravels[indexPath.row]
        
        cell.bind(travel: travel)
        cell.hideThumbnail()
        cell.selectionStyle = .none
        
        return cell
    }
}

extension MemorySelectViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TravelTableViewCell.identifier) as? TravelTableViewCell else { return }
        
        if let selectedIndexPath = selectedIndexPath {
            // 셀 선택을 해제하는 경우
            if selectedIndexPath == indexPath {
                memorySelectView.tableView.deselectRow(at: indexPath, animated: true)
                self.selectedIndexPath = nil
                cell.setSelected(false, animated: true)
                memorySelectView.setConfirmButtonStatus(isEnabled: false)
            }
        } else {
            // 셀을 선택하는 경우
            self.selectedIndexPath = indexPath
            cell.setSelected(true, animated: true)
            memorySelectView.setConfirmButtonStatus(isEnabled: true)
        }
    }
}
