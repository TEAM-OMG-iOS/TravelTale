//
//  TravelAdditionViewController.swift
//  TravelTale
//
//  Created by Kinam on 6/4/24.
//

import UIKit

final class TravelSelectViewController: BaseViewController {
    
    // MARK: - properties
    private let travelSelectView = TravelSelectView()
    
    private var travels: [Travel] = [] {
        didSet {
            splitTravels()
            travelSelectView.tableView.reloadData()
        }
    }
    
    private var upcomingTravels: [Travel] = []
    private var pastTravels: [Travel] = []
    
    private var preSelectedIndexPath: IndexPath?
    
    // MARK: - life cycles
    override func loadView() {
        view = travelSelectView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        travelSelectView.startLoadingAnimation()
    }
    
    // MARK: - methods
    override func configureStyle() {
        configureNavigationBar()
    }
    
    override func configureDelegate() {
        travelSelectView.tableView.delegate = self
        travelSelectView.tableView.dataSource = self
        
        //register
        travelSelectView.tableView.register(TravelTableViewCell.self, forCellReuseIdentifier: TravelTableViewCell.identifier)
    }
    
    override func configureAddTarget() {
        travelSelectView.nextBtn.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "내 여행에 추가"
        navigationItem.leftBarButtonItem = travelSelectView.backButton
    }
    
    // TODO: travelData 추가 함수
    
    @objc private func tappedButton() {
        guard let selectedIndexPath = travelSelectView.tableView.indexPathForSelectedRow else { return }
        let selectedData = upcomingTravels[selectedIndexPath.row]
        let nextVC = ScheduleCreateViewController()
        nextVC.selectedData = selectedData
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    private func splitTravels() {
        let today = Date()
        upcomingTravels.removeAll()
        pastTravels.removeAll()
        
        for travel in travels {
            if travel.endDate >= today {
                upcomingTravels.append(travel)
            } else {
                pastTravels.append(travel)
            }
        }
    }
}

extension TravelSelectViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TravelTableViewCell.identifier) as? TravelTableViewCell else { return }
        
        if let selectedIndexPath =
            preSelectedIndexPath {
            if selectedIndexPath == indexPath {
                travelSelectView.tableView.deselectRow(at: indexPath, animated: true)
                preSelectedIndexPath = nil
                travelSelectView.updateButtonState() // TODO: 셀 수정 PR 머지 이후 삭제
//                cell.setSelected(false, animated: true) // 셀 수정 PR 머지 이후 주석 해제
            }
        } else {
            preSelectedIndexPath = indexPath
            travelSelectView.updateButtonState() // TODO: 셀 수정 PR 머지 이후 삭제
//            cell.setSelected(true, animated: true) // 셀 수정 PR 머지 이후 주석 해제
        }
    }
}

extension TravelSelectViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcomingTravels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TravelTableViewCell.identifier, for: indexPath) as? TravelTableViewCell else { return UITableViewCell() }
        
        let travel = upcomingTravels[indexPath.row]
//        cell.bind(travel: travel)
        
        return cell
    }
}
