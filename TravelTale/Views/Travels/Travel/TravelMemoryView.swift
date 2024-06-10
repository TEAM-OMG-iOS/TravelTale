//
//  TravelMemoryView.swift
//  TravelTale
//
//  Created by 유림 on 6/8/24.
//

import UIKit

final class TravelMemoryView: BaseView {
    
    // MARK: - properties
    let addButtonView = LightGreenButton()
    let tableView = UITableView()
    
    
    // MARK: - methods
    override func configureUI() {
        super.configureUI()
        addButtonView.configureButton(text: "추억 남기기")
    }
    
    override func configureHierarchy() {
        [addButtonView,
         tableView].forEach { self.addSubview($0) }
    }
    
    override func configureConstraints() {
        
        let horizontalInset = 20
        
        addButtonView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(26)
            $0.horizontalEdges.equalToSuperview().inset(horizontalInset)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(addButtonView.snp.bottom).offset(26)
            $0.horizontalEdges.equalToSuperview().inset(horizontalInset)
            $0.bottom.equalToSuperview()
        }
    }
}
