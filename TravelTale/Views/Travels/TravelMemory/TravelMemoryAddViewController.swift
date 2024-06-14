//
//  TravelMemoryTravelSelectionViewController.swift
//  TravelTale
//
//  Created by 유림 on 6/10/24.
//

import UIKit

final class TravelMemoryAddViewController: BaseViewController {
    
    // MARK: - properties
    private let travelMemoryAddView = TravelMemoryAddView()
    
    private var travels: [Travel] = [] {
        didSet {
            setNoMemoryTravels()
        }
    }
    private var noMemoryTravels: [Travel] = []
    
    private var selectedIndexPath: IndexPath?
    
    // MARK: - life cycles
    override func loadView() {
        view = travelMemoryAddView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addTemporaryData()
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
        configureNavigationBarItems()
        travelMemoryAddView.tableView.separatorStyle = .none
    }
    
    override func configureDelegate() {
        travelMemoryAddView.tableView.dataSource = self
        travelMemoryAddView.tableView.delegate = self
        
        travelMemoryAddView.tableView.register(TravelTableViewCell.self, forCellReuseIdentifier: TravelTableViewCell.identifier)
    }
    
    override func configureAddTarget() {
        travelMemoryAddView.exitButton.target = self
        travelMemoryAddView.exitButton.action = #selector(tappedExitButton)
        
        travelMemoryAddView.confirmButton.addTarget(self, action: #selector(tappedConfirmButton), for: .touchUpInside)
    }
    
    func configureNavigationBarItems() {
        navigationItem.title = "추억 남기기"
        navigationItem.leftBarButtonItem = travelMemoryAddView.exitButton
    }
    
    func setNoMemoryTravels() {
        for travel in travels {
            let isMemoryNoteEmpty = travel.memoryNote == nil
            let isMemoryImagesEmpty = travel.memoryImageDatas.isEmpty
            
            if isMemoryNoteEmpty && isMemoryImagesEmpty {
                noMemoryTravels.append(travel)
            }
        }
    }
    
    // MARK: - objc functions
    @objc func tappedExitButton() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func tappedConfirmButton() {
        if let selectedIndexPath = selectedIndexPath {
            let selectedTravel = noMemoryTravels[selectedIndexPath.row]
            let nextVC = TravelMemoryDetailEditViewController(travelData: selectedTravel)
            navigationController?.pushViewController(nextVC, animated: true)
        } else {
            print("selectedIndexPath 없음")
        }
    }
}

extension TravelMemoryAddViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noMemoryTravels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TravelTableViewCell.identifier) as? TravelTableViewCell else { return UITableViewCell() }
        
        let travel = noMemoryTravels[indexPath.row]
        
        cell.bind(travel: travel)
        cell.selectionStyle = .none
        
        return cell
    }
}

extension TravelMemoryAddViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TravelTableViewCell.identifier) as? TravelTableViewCell else { return }
        
        if let selectedIndexPath = selectedIndexPath {
            // 셀 선택을 해제하는 경우
            if selectedIndexPath == indexPath {
                travelMemoryAddView.tableView.deselectRow(at: indexPath, animated: true)
                self.selectedIndexPath = nil
                cell.setSelected(false, animated: true)
                travelMemoryAddView.setConfirmButtonStatus(isEnabled: false)
            }
        } else {
            // 셀을 선택하는 경우
            self.selectedIndexPath = indexPath
            cell.setSelected(true, animated: true)
            travelMemoryAddView.setConfirmButtonStatus(isEnabled: true)
        }
    }
}
