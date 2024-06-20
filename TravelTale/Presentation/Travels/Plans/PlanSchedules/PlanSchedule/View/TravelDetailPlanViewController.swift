//
//  TravelDetailPlanViewController.swift
//  TravelTale
//
//  Created by 김정호 on 6/8/24.
//

import UIKit
import FloatingPanel

final class TravelDetailPlanViewController: BaseViewController {
    
    // MARK: - properties
    let travelDetailPlanView = TravelDetailPlanView()
    
    var panelState: FloatingPanelState = .tip
    
    private let temporaryData = [1,2,3,4,5,6,7,8,9,10]
    
    // MARK: - life cycles
    override func loadView() {
        view = travelDetailPlanView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - methods
    override func configureStyle() {
        travelDetailPlanView.tableView.separatorStyle = .none
    }
    
    override func configureDelegate() {
        travelDetailPlanView.tableView.dataSource = self
        
        travelDetailPlanView.tableView.register(TravelDetailPlanHeaderCell.self,
                                                forCellReuseIdentifier: TravelDetailPlanHeaderCell.identifier)
        travelDetailPlanView.tableView.register(TravelDetailPlanContentCell.self,
                                                forCellReuseIdentifier: TravelDetailPlanContentCell.identifier)
        travelDetailPlanView.tableView.register(TravelDetailPlanFooterCell.self,
                                                forCellReuseIdentifier: TravelDetailPlanFooterCell.identifier)
    }
    
    private func tappedOptionButton(action: UIAction) {
        print("tappedOptionButton")
    }
    
    @objc private func tappedPlaceAddButton() {
        print("tappedPlaceAddButton")
    }
    
    @objc private func tappedMemoAddButton() {
        print("tappedMemoAddButton")
    }
}

// MARK: - extensions
extension TravelDetailPlanViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return temporaryData.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TravelDetailPlanHeaderCell.identifier, for: indexPath) as? TravelDetailPlanHeaderCell else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.collectionView.register(TravelDetailPlanHeaderContentCell.self,
                                         forCellWithReuseIdentifier: TravelDetailPlanHeaderContentCell.identifier)
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TravelDetailPlanContentCell.identifier, for: indexPath) as? TravelDetailPlanContentCell else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            cell.optionButton.menu = UIMenu(children: [
                UIAction(title: "수정", handler: tappedOptionButton),
                UIAction(title: "삭제", attributes: .destructive, handler: tappedOptionButton),
            ])
            
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TravelDetailPlanFooterCell.identifier, for: indexPath) as? TravelDetailPlanFooterCell else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            cell.placeAddButton.addTarget(self, action: #selector(tappedPlaceAddButton), for: .touchUpInside)
            cell.memoAddButton.addTarget(self, action: #selector(tappedMemoAddButton), for: .touchUpInside)
            
            return cell
        }
    }
}

extension TravelDetailPlanViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row + 1)
    }
}

extension TravelDetailPlanViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return temporaryData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TravelDetailPlanHeaderContentCell.identifier, for: indexPath) as? TravelDetailPlanHeaderContentCell else { return UICollectionViewCell() }
        
        return cell
    }
}

extension TravelDetailPlanViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = ("Day \(indexPath.row + 1)").size(withAttributes: [.font : UIFont.oaGothic(size: 15, weight: .heavy)])
        return CGSize(width: itemSize.width, height: itemSize.height + 7)
    }
}
