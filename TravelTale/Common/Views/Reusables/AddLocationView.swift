//
//  AddLocationView.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/13/24.
//

import UIKit

final class AddLocationView: BaseView {
    
    // MARK: - properties
    private let guideLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 18, weight: .bold))
    }
    
    let tableView = UITableView()
    
    // MARK: - methods
    override func configureHierarchy() {
        [guideLabel,
         tableView].forEach {
            self.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        guideLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(36)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(guideLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    func bind(text: String) {
        guideLabel.text = text
    }
}

