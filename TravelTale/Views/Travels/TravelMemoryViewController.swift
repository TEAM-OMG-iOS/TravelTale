//
//  TravelMemoryViewController.swift
//  TravelTale
//
//  Created by 유림 on 6/8/24.
//

import UIKit

final class TravelMemoryViewController: BaseViewController {
    
    // MARK: - properties
    private let travelMemoryView = TravelMemoryView()
    private let travelViewModel = TravelViewModel()
    
    
    // MARK: - life cycles
    override func loadView() {
        view = travelMemoryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTemporaryData()
    }
    
    
    // MARK: - methods
    // TODO: 임시 travel 데이터 넣는 함수 (추후 삭제 예정)
    private func addTemporaryData() {
        travelViewModel.travelArray.value.append(contentsOf: [
            Travel(
                image: nil,
                title: "24년의 가족 여행",
                startDate: createDate(year: 2024, month: 4, day: 1) ?? Date(),
                endDate: createDate(year: 2024, month: 4, day: 5) ?? Date(),
                province: nil)
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
        travelMemoryView.tableView.separatorStyle = .none
    }
    
    override func configureDelegate() {
        travelMemoryView.tableView.dataSource = self
        travelMemoryView.tableView.register(TravelTableViewCell.self, forCellReuseIdentifier: TravelTableViewCell.identifier)
    }
    
    override func configureAddTarget() {
        travelMemoryView.addButtonView.button.addTarget(self, action: #selector(tappedAddButton), for: .touchUpInside)
    }
    
    override func bind() { 
        travelViewModel.travelArray.bind { [weak self] _ in
            guard let self = self else { return }
            travelMemoryView.tableView.reloadData()
        }
    }
    
    
    // MARK: - objc method
    @objc func tappedAddButton() {
        let travelMemoryAddVC = TravelMemoryAddViewController()
        self.navigationController?.pushViewController(travelMemoryAddVC, animated: true)
    }
}

// MARK: - Extensions
extension TravelMemoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelViewModel.travelArray.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TravelTableViewCell.identifier, for: indexPath) as? TravelTableViewCell else { return UITableViewCell() }
        
        
        let travel = travelViewModel.travelArray.value[indexPath.row]
        let period = travelViewModel.returnPeriodString(
            startDate: travel.startDate,
            endDate: travel.endDate
        )
        
        cell.bind(travel: travel, period: period)
        cell.selectionStyle = .none
        
        return cell
    }
}
