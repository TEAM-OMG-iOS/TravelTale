//
//  CategoryTabView.swift
//  TravelTale
//
//  Created by 배지해 on 6/16/24.
//

import UIKit

final class CategoryTabView: BaseView {
    
    // MARK: - properties
    private let realmManager = RealmManager.shared
    
    private let regionImage = UIImageView().then {
        $0.isHidden = true
        $0.tintColor = .gray80
        $0.image = UIImage(systemName: "location.circle")
    }
    
    private let regionLabel = UILabel().then {
        $0.configureLabel(color: .gray80, font: .pretendard(size: 12, weight: .bold))
    }
    
    let tableView = UITableView()
    
    private let notFoundView = NotFoundView().then {
        $0.isHidden = true
    }
    
    // MARK: - methods
    override func configureUI() {
        super.configureUI()
        tableView.separatorStyle = .none
    }
    
    override func configureHierarchy() {
        addSubview(regionImage)
        addSubview(regionLabel)
        addSubview(tableView)
        addSubview(notFoundView)
    }
    
    override func configureConstraints() {
        regionImage.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(24)
            $0.size.equalTo(15)
        }
        
        regionLabel.snp.makeConstraints {
            $0.leading.equalTo(regionImage.snp.trailing).offset(4)
            $0.top.equalToSuperview().inset(24)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(regionImage.snp.bottom).offset(12)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        
        notFoundView.snp.makeConstraints {
            $0.edges.equalTo(tableView)
        }
    }
    
    func setNotFoundViewText(text: String) {
        notFoundView.setLabel(text: text)
    }
    
    func showNotFoundView(_ isNotFound: Bool) {
        notFoundView.isHidden = !isNotFound
    }
    
    func setRegionLabel() {
        if let region = realmManager.fetchRegion() {
            regionImage.isHidden = false
            regionLabel.text = "\(region.sido) \(region.sigungu ?? "")"
        }
    }
}
