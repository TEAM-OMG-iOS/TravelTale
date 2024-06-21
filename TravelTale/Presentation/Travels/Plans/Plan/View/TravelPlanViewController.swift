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
    }
    
    
    // MARK: - methods
    // TODO: travels 데이터 추가
    
    override func configureStyle() {
        travelPlanView.tableView.separatorStyle = .none
        travelPlanView.tableView.sectionHeaderTopPadding = 0
    }
    
    override func configureDelegate() {
        travelPlanView.tableView.dataSource = self
        travelPlanView.tableView.delegate = self
        
        // register
        travelPlanView.tableView.register(TravelTableViewCell.self, forCellReuseIdentifier: TravelTableViewCell.identifier)
        travelPlanView.tableView.register(TravelHeaderView.self, forHeaderFooterViewReuseIdentifier: TravelHeaderView.identifier)
        travelPlanView.tableView.register(TravelFooterView.self, forHeaderFooterViewReuseIdentifier: TravelFooterView.identifier)
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
    
    @objc func tappedAddButton() {
        let PlanAddTitleVC = PlanAddTitleViewController()
        self.navigationController?.pushViewController(PlanAddTitleVC, animated: true)
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
        
        let _ = (indexPath.section == 0) ? upcomingTravels[indexPath.row] : pastTravels[indexPath.row]
        
//        cell.bind(travel: travel)
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
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TravelHeaderView.identifier) as? TravelHeaderView else { return UIView() }
        
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
        return TravelFooterView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
}
