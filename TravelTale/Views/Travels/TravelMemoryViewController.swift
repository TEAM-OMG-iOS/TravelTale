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
    private var travels: [Travel] = [] {
        didSet {
            travelMemoryView.tableView.reloadData()
        }
    }
    
    
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
        travels.append(contentsOf: [
            Travel(
                image: nil,
                title: "24년의 가족 여행",
                startDate: createDate(year: 2024, month: 4, day: 1) ?? Date(),
                endDate: createDate(year: 2024, month: 4, day: 5) ?? Date(),
                province: nil,
                memoryNote: "yayyyy~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~",
                memoryImageDatas: [UIImage(named: "splash")?.jpegData(compressionQuality: 0.5), UIImage(named: "my_travel")?.jpegData(compressionQuality: 1)])
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
        travelMemoryView.tableView.delegate = self
        travelMemoryView.tableView.register(TravelTableViewCell.self, forCellReuseIdentifier: TravelTableViewCell.identifier)
    }
    
    override func configureAddTarget() {
        travelMemoryView.addButtonView.button.addTarget(self, action: #selector(tappedAddButton), for: .touchUpInside)
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
        return travels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TravelTableViewCell.identifier, for: indexPath) as? TravelTableViewCell else { return UITableViewCell() }
        
        cell.bind(travel: travels[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
}

extension TravelMemoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TravelTableViewCell.identifier, for: indexPath) as? TravelTableViewCell else { return }
        
        let travelMemoryDetailViewController = TravelMemoryDetailViewController(travelData: travels[indexPath.row])
        navigationController?.pushViewController(travelMemoryDetailViewController, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
