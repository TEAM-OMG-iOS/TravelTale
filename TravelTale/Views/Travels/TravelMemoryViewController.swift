//
//  TravelMemoryViewController.swift
//  TravelTale
//
//  Created by 유림 on 6/8/24.
//

import UIKit

class TravelMemoryViewController: BaseViewController {
    
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
    // 임시 travel 데이터 넣는 함수 (추후 삭제 예정)
    private func addTemporaryData() {
        travelViewModel.travelArray.value.append(contentsOf: [
            Travel(
                image: nil,
                title: "24년의 가족 여행",
                startDate: DateComponents(year: 2024, month: 4, day: 2).date ?? Date(),
                endDate: DateComponents(year: 2024, month: 4, day: 5).date ?? Date(),
                province: nil)
        ])
    }
    
    override func configureStyle() {
        travelMemoryView.tableView.separatorStyle = .none
    }
    
    override func configureDelegate() {
        travelMemoryView.tableView.dataSource = self
        travelMemoryView.tableView.register(TravelTableViewCell.self, forCellReuseIdentifier: TravelTableViewCell.identifier)
    }
    
    override func configureAddTarget() {
        travelMemoryView.addView.button.addTarget(self, action: #selector(tappedAddButton), for: .touchUpInside)
    }
    
    override func bind() {
        travelViewModel.travelArray.bind { _ in
            self.travelMemoryView.tableView.reloadData()
        }
    }
    
    // MARK: - objc method
    @objc func tappedAddButton() {
        print("tappedAddButton")
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
        let travelPeriod = travelViewModel.returnPeriodString(startDate: travel.startDate, endDate: travel.endDate)
        
        cell.bind(image: travel.image, title: travel.title, period: travelPeriod, province: travel.province)
        
        cell.selectionStyle = .none
        
        return cell
    }
    
}
