//
//  TravelMemorySelectionView.swift
//  TravelTale
//
//  Created by 유림 on 6/10/24.
//

import UIKit

final class MemorySelectView: BaseView {
    
    // MARK: - properties
    let backButton = UIBarButtonItem().then {
        $0.style = .done
        $0.image = UIImage(systemName: "chevron.left")
        $0.tintColor = .gray90
    }
    
    let tableView = UITableView().then {
        $0.backgroundColor = .white
    }
    
    let confirmButton = GreenButton().then {
        $0.configureButton(fontColor: .white, font: .pretendard(size: 18, weight: .bold), text: "선택 완료")
    }
    
    // MARK: - methods
    override func configureUI() {
        super.configureUI()
        setConfirmButtonStatus(isEnabled: false)
    }
    
    override func configureHierarchy() {
        [tableView,
         confirmButton].forEach { self.addSubview($0) }
    }
    
    override func configureConstraints() {
        tableView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
    }
    
    func setConfirmButtonStatus(isEnabled: Bool) {
        if isEnabled {
            confirmButton.backgroundColor = .green100
            confirmButton.isEnabled = true
        } else {
            confirmButton.backgroundColor = .green10
            confirmButton.isEnabled = false
        }
    }
}
