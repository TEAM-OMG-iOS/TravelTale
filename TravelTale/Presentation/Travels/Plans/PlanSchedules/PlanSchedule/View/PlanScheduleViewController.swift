//
//  PlanScheduleViewController.swift
//  TravelTale
//
//  Created by 김정호 on 6/8/24.
//

import UIKit
import FloatingPanel

final class PlanScheduleViewController: BaseViewController {
    
    // MARK: - properties
    let planScheduleView = PlanScheduleView()
    
    var panelState: FloatingPanelState = .tip
    
    private lazy var tappedDaySchedules = Array(travel.schedules.filter { $0.day == "\(self.tappedDay)" })
    private var tappedDay = 1
    private var travel: Travel
    
    // MARK: - life cycles
    init(travel: Travel) {
        self.travel = travel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = planScheduleView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - methods
    override func configureStyle() {
        planScheduleView.tableView.separatorStyle = .none
    }
    
    override func configureDelegate() {
        planScheduleView.tableView.dataSource = self
        
        planScheduleView.tableView.register(PlanScheduleHeaderCell.self,
                                            forCellReuseIdentifier: PlanScheduleHeaderCell.identifier)
        planScheduleView.tableView.register(PlanScheduleContentCell.self,
                                            forCellReuseIdentifier: PlanScheduleContentCell.identifier)
        planScheduleView.tableView.register(PlanScheduleFooterCell.self,
                                            forCellReuseIdentifier: PlanScheduleFooterCell.identifier)
    }
    
    private func fetchTotalDay() -> Int {
        let endDay = Calendar.current.component(.day, from: travel.endDate)
        let startDay = Calendar.current.component(.day, from: travel.startDate)
        
        return endDay - startDay + 1
    }
    
    private func tappedOptionButton(action: UIAction) {
        print("tappedOptionButton")
    }
    
    @objc private func tappedPlaceAddButton() {
        let planScheduleAddPlaceVC = PlanScheduleAddPlaceViewController(travel: travel,
                                                                        selectedDay: String(tappedDay),
                                                                        allDays: String(fetchTotalDay()))
        planScheduleAddPlaceVC.completion = { travel in
            self.travel = travel
            self.tappedDaySchedules = Array(travel.schedules.filter { $0.day == "\(self.tappedDay)" })
            self.planScheduleView.tableView.reloadData()
        }
        
        navigationController?.pushViewController(planScheduleAddPlaceVC, animated: true)
    }
    
    @objc private func tappedMemoAddButton() {
        let planScheduleAddMemoVC = PlanScheduleAddMemoViewController(day: String(tappedDay), travel: travel)
        planScheduleAddMemoVC.completion = { travel in
            self.travel = travel
            self.tappedDaySchedules = Array(travel.schedules.filter { $0.day == "\(self.tappedDay)" })
            self.planScheduleView.tableView.reloadData()
        }
        
        navigationController?.pushViewController(planScheduleAddMemoVC, animated: true)
    }
}

// MARK: - extensions
extension PlanScheduleViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return tappedDaySchedules.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PlanScheduleHeaderCell.identifier, for: indexPath) as? PlanScheduleHeaderCell else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.collectionView.register(PlanScheduleHeaderContentCell.self,
                                         forCellWithReuseIdentifier: PlanScheduleHeaderContentCell.identifier)
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PlanScheduleContentCell.identifier, for: indexPath) as? PlanScheduleContentCell else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            cell.optionButton.menu = UIMenu(children: [
                UIAction(title: "수정", handler: tappedOptionButton),
                UIAction(title: "삭제", attributes: .destructive, handler: tappedOptionButton),
            ])
            
            cell.bind(state: panelState, schedule: tappedDaySchedules[indexPath.row])
            
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PlanScheduleFooterCell.identifier, for: indexPath) as? PlanScheduleFooterCell else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            cell.placeAddButton.addTarget(self, action: #selector(tappedPlaceAddButton), for: .touchUpInside)
            cell.memoAddButton.addTarget(self, action: #selector(tappedMemoAddButton), for: .touchUpInside)
            
            return cell
        }
    }
}

extension PlanScheduleViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tappedDay = indexPath.row + 1
        collectionView.reloadData()
        
        tappedDaySchedules = Array(travel.schedules.filter { $0.day == "\(self.tappedDay)" })
        planScheduleView.tableView.reloadData()
    }
}

extension PlanScheduleViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchTotalDay()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlanScheduleHeaderContentCell.identifier, for: indexPath) as? PlanScheduleHeaderContentCell else { return UICollectionViewCell() }
        
        if tappedDay == indexPath.row + 1 {
            cell.bind(day: indexPath.row + 1, isTapped: true)
        } else {
            cell.bind(day: indexPath.row + 1, isTapped: false)
        }
        
        return cell
    }
}

extension PlanScheduleViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = ("Day \(indexPath.row + 1)").size(withAttributes: [.font : UIFont.oaGothic(size: 15, weight: .heavy)])
        return CGSize(width: itemSize.width, height: itemSize.height + 7)
    }
}
