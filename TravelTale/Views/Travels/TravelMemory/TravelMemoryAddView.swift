//
//  TravelMemorySelectionView.swift
//  TravelTale
//
//  Created by 유림 on 6/10/24.
//

import UIKit

final class TravelMemoryAddView: BaseView {
    
    // MARK: - properties
    let exitButton = UIBarButtonItem().then {
        $0.style = .done
        $0.image = UIImage(systemName: "xmark")
        $0.tintColor = .gray90
    }
    
    let navTitleLabel = UILabel().then {
        $0.configureLabel(color: .black, font: .oaGothic(size: 18, weight: .heavy), text: "추억 남기기")
    }
    
    let tableView = UITableView()
    
    let confirmButton = GreenButton().then {
        $0.configureButton(fontColor: .white, font: .pretendard(size: 18, weight: .bold), text: "선택 완료")
    }
    
    // MARK: - methods
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
}
