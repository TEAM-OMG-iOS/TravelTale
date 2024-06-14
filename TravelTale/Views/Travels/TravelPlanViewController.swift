//
//  TravelPlanViewController.swift
//  TravelTale
//
//  Created by 유림 on 6/7/24.
//

import UIKit

final class TravelPlanViewController: BaseViewController {
    
    // MARK: - properties
    private let travelPlanView = TravelPlanView()
    
    private var travels: [Travel] = [] {
        didSet {
            splitTravels()
            travelPlanView.tableView.reloadData()
        }
    }
    
    private var upcomingTravels: [Travel] = []
    private var pastTravels: [Travel] = []
    
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
    // TODO: 임시 travel 데이터 넣는 함수 (추후 삭제 예정)
    private func addTemporaryData() {
        travels.append(contentsOf: [
            Travel(
                image: nil,
                title: "200일 여행 with 남자친구",
                startDate: createDate(year: 2024, month: 9, day: 19) ?? Date(),
                endDate: createDate(year: 2024, month: 9, day: 21) ?? Date(),
                province: "대구",
                memoryNote: nil),
            Travel(
                image: nil,
                title: "24년의 가족 여행",
                startDate: createDate(year: 2024, month: 4, day: 1) ?? Date(),
                endDate: createDate(year: 2024, month: 4, day: 5) ?? Date(),
                province: nil,
                memoryNote: "yayyyy~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~",
                memoryImageDatas: [UIImage(named: "splash")?.jpegData(compressionQuality: 0.5), UIImage(named: "my_travel")?.jpegData(compressionQuality: 1)]),
            Travel(
                image: nil,
                title: "25년의 가족 여행",
                startDate: createDate(year: 2025, month: 4, day: 1) ?? Date(),
                endDate: createDate(year: 2025, month: 4, day: 5) ?? Date(),
                province: nil,
                memoryNote: nil)
        ])
    }
    
    // TODO: date 데이터 만드는 함수 (추후 삭제 예정)
    private func createDate(year: Int, month: Int, day: Int) -> Date? {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        return Calendar.current.date(from: dateComponents)
    }
    
    override func configureStyle() {
        travelPlanView.tableView.separatorStyle = .none
        travelPlanView.tableView.sectionHeaderTopPadding = 0
    }
    
    override func configureDelegate() {
        travelPlanView.tableView.dataSource = self
        travelPlanView.tableView.delegate = self
        
        // register
        travelPlanView.tableView.register(TravelTableViewCell.self, forCellReuseIdentifier: TravelTableViewCell.identifier)
        travelPlanView.tableView.register(TravelSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: TravelSectionHeaderView.identifier)
        travelPlanView.tableView.register(SpaceFooterView.self, forHeaderFooterViewReuseIdentifier: SpaceFooterView.identifier)
    }
    
    override func configureAddTarget() {
        travelPlanView.addButtonView.button.addTarget(self, action: #selector(tappedAddButton), for: .touchUpInside)
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
    
    // MARK: - objc method
    @objc func tappedAddButton() {
        print("tappedAddButton")
    }
}


// MARK: - Extensions
extension TravelPlanViewController: UITableViewDataSource {
    // section
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // row cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return upcomingTravels.count
        } else {
            return pastTravels.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TravelTableViewCell.identifier, for: indexPath) as? TravelTableViewCell else { return UITableViewCell() }
        
        let travel: Travel
        if indexPath.section == 0 {
            travel = upcomingTravels[indexPath.row]
        } else {
            travel = pastTravels[indexPath.row]
        }
        
        cell.bind(travel: travel)
        cell.selectionStyle = .none
        
        return cell
    }
}

extension TravelPlanViewController: UITableViewDelegate {
    // cell 선택 시
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = TravelDetailViewController()
        navigationController?.pushViewController(nextVC, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    // Header, Footer
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TravelSectionHeaderView.identifier) as? TravelSectionHeaderView else { return UIView() }
        
        if section == 0 {
            headerView.bind(title: "다가오는 여행")
        } else {
            headerView.bind(title: "다녀온 여행")
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 28
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return SpaceFooterView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
}
