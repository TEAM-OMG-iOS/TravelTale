//
//  TravelViewController.swift
//  TravelTale
//
//  Created by 김정호 on 6/3/24.
//

import UIKit

class TravelViewController: BaseViewController {
    
    // MARK: - Properties
    
    let travelView = TravelView()
    
    let travelViewModel = TravelViewModel()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        view = travelView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTemporaryData()
        travelView.addButtonLabel.text = "새 여행 추가"
    }
    
    // MARK: - Methods
    
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
        travelView.tableView.separatorStyle = .none
    }
    
    override func configureDelegate() {
        travelView.tableView.dataSource = self
        travelView.tableView.register(TravelTableViewCell.self, forCellReuseIdentifier: TravelTableViewCell.identifier)
    }
    
    override func configureAddTarget() { }
    
    override func bind() { 
        travelViewModel.travelArray.bind { _ in
            self.travelView.tableView.reloadData()
        }
    }
    
}


// MARK: - Extensions

extension TravelViewController: UITableViewDataSource {
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
