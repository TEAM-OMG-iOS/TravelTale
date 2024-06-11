//
//  TravelAdditionViewController.swift
//  TravelTale
//
//  Created by Kinam on 6/4/24.
//

import UIKit
import SnapKit

final class TravelSelectViewController: BaseViewController {
    // MARK: - properties
    private let travelSelectView = TravelSelectView()
    
    private let travelViewModel = TravelViewModel()
    
    private var preselectedIndexPath: IndexPath?
    
    // MARK: - life cycles
    override func loadView() {
        view = travelSelectView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        addTemporaryData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        travelSelectView.startLoadingAnimation()
    }
    
    // MARK: - methods
    override func configureDelegate() {
        travelSelectView.tableView.delegate = self
        travelSelectView.tableView.dataSource = self
        
        //register
        travelSelectView.tableView.register(TravelTableViewCell.self, forCellReuseIdentifier: TravelTableViewCell.identifier)
    }
    
    override func configureAddTarget() {
        travelSelectView.nextBtn.tag = 0
        travelSelectView.nextBtn.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "내 여행에 추가"
        navigationItem.leftBarButtonItem = travelSelectView.backButton
    }
    
    // TODO: 임시 travel 데이터 넣는 함수 (추후 삭제 예정)
    private func addTemporaryData() {
        travelViewModel.upcomingTravels.append(contentsOf: [
            Travel(
                image: nil,
                title: "200일 여행 with 남자친구",
                startDate: Date(),
                endDate: Date(),
                province: "대구"),
            Travel(
                image: nil,
                title: "24년의 가족 여행",
                startDate: Date(),
                endDate: Date(),
                province: nil)
        ])
        print(travelViewModel.upcomingTravels.count)
    }
    
    // MARK: - objc func
    @objc private func tappedButton() {
        guard let selectedIndexPath = travelSelectView.tableView.indexPathForSelectedRow else { return }
        let selectedData = travelViewModel.upcomingTravels[selectedIndexPath.row]
        let nextVC = ScheduleCreateViewController()
        nextVC.selectedData = selectedData
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension TravelSelectViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TravelTableViewCell.identifier) as? TravelTableViewCell else { return }
        
        if let selectedIndexPath =
            preselectedIndexPath {
            if selectedIndexPath == indexPath {
                travelSelectView.tableView.deselectRow(at: indexPath, animated: true)
                preselectedIndexPath = nil
                travelSelectView.updateButtonState()
            }
        } else {
            preselectedIndexPath = indexPath
            travelSelectView.updateButtonState()
        }
    }
}

extension TravelSelectViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelViewModel.upcomingTravels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TravelTableViewCell.identifier, for: indexPath) as? TravelTableViewCell else { return UITableViewCell() }
        
        let travel = travelViewModel.upcomingTravels[indexPath.row]
        
        let period = travelViewModel.returnPeriodString(
            startDate: travel.startDate,
            endDate: travel.endDate
        )
        
        cell.bind(travel: travel, period: period)
        return cell
    }
}
