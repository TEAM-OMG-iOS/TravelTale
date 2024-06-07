//
//  TravelPlanViewController.swift
//  TravelTale
//
//  Created by 유림 on 6/7/24.
//

import UIKit

class TravelPlanViewController: BaseViewController {
    
    // MARK: - properties
    private let travelPlanView = TravelPlanView()
    private let travelViewModel = TravelViewModel()
    private let sectionHeader = ["다가오는 여행", "다녀온 여행"]
    
    // MARK: - life cycles
    override func loadView() {
        view = travelPlanView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTemporaryData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - methods
    // 임시 travel 데이터 넣는 함수 (추후 삭제 예정)
    func addTemporaryData() {
        travelViewModel.travelArray.value.append(contentsOf: [
            Travel(
                image: nil,
                title: "200일 여행 with 남자친구",
                startDate: DateComponents(year: 2024, month: 9, day: 19).date ?? Date(),
                endDate: DateComponents(year: 2024, month: 9, day: 21).date ?? Date(),
                province: "대구"),
            Travel(
                image: nil,
                title: "24년의 가족 여행",
                startDate: DateComponents(year: 2024, month: 4, day: 2).date ?? Date(),
                endDate: DateComponents(year: 2024, month: 4, day: 5).date ?? Date(),
                province: nil)
        ])
    }
    
    override func configureStyle() {
        travelPlanView.tableView.separatorStyle = .none
    }
    
    override func configureDelegate() {
        travelPlanView.tableView.dataSource = self
        //        travelPlanView.tableView.delegate = self
        travelPlanView.tableView.register(TravelTableViewCell.self, forCellReuseIdentifier: TravelTableViewCell.identifier)
    }
    
    override func configureAddTarget() {
        travelPlanView.addView.button.addTarget(self, action: #selector(tappedAddButton), for: .touchUpInside)
    }
    
    override func bind() {
        travelViewModel.travelArray.bind { _ in
            self.travelViewModel.splitTravelArray()
            self.travelPlanView.tableView.reloadData()
        }
    }
    
    
    // MARK: - objc method
    @objc func tappedAddButton() {
        print("tappedAddButton")
    }
}


// MARK: - Extensions
extension TravelPlanViewController: UITableViewDataSource {
    // section
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHeader.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeader[section]
    }
    
    // row cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            print("section 0 -> \(travelViewModel.upcomingTravels.count)열")
            return travelViewModel.upcomingTravels.count
        } else {
            print("section 1 -> \(travelViewModel.pastTravels.count)열")
            return travelViewModel.pastTravels.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TravelTableViewCell.identifier, for: indexPath) as? TravelTableViewCell else { return UITableViewCell() }
        
        let travel: Travel
        if indexPath.section == 0 {
            travel = travelViewModel.upcomingTravels[indexPath.row]
        } else {
            travel = travelViewModel.pastTravels[indexPath.row]
        }
        
        let period = travelViewModel.returnPeriodString(
            startDate: travel.startDate,
            endDate: travel.endDate
        )
        
        cell.bind(travel: travel, period: period)
        cell.selectionStyle = .none
        
        return cell
    }
}

