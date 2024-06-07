//
//  TravelMemoryView.swift
//  TravelTale
//
//  Created by 유림 on 6/8/24.
//

import UIKit

class TravelMemoryView: BaseView {
    
    // MARK: - properties
    let addView = TravelAddView()
    let tableView = UITableView()
    
    
    // MARK: - methods
    override func configureUI() {
        super.configureUI()
        addView.bind(text: "추억 남기기")
    }
    
    override func configureHierarchy() {
        [addView,
         tableView].forEach { self.addSubview($0) }
    }
    
    override func configureConstraints() {
        
        let horizontalInset = 20
        
        addView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(26)
            $0.horizontalEdges.equalToSuperview().inset(horizontalInset)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(addView.snp.bottom).offset(26)
            $0.horizontalEdges.equalToSuperview().inset(horizontalInset)
            $0.bottom.equalToSuperview()
        }
    }
}