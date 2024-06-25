//
//  TravelPlanView.swift
//  TravelTale
//
//  Created by 유림 on 6/7/24.
//

import UIKit

final class PlanView: BaseView {
    
    // MARK: - properties
    let addButtonView = LightGreenButton()
    
    let tableView = UITableView(frame: CGRect.zero, style: .grouped).then {
        $0.backgroundColor = .white
    }
    
    let notFoundStackView = UIStackView().then {
        $0.configureView(color: .white)
        $0.axis = .vertical
        $0.spacing = 30
    }
    
    let notFoundImageView = UIImageView().then {
        $0.image = UIImage(named: "not_found_train")
        $0.contentMode = .scaleAspectFit
    }
    
    let notFoundLabel = UILabel().then {
        $0.configureLabel(color: .gray70,
                          font: .pretendard(size: 18, weight: .medium),
                          text: "기록된 계획이 없습니다.")
    }
    
    // MARK: - methods
    override func configureUI() {
        super.configureUI()
        addButtonView.configureButton(text: "새 여행 추가")
    }
    
    override func configureHierarchy() {
        [addButtonView,
         tableView,
         notFoundStackView].forEach { self.addSubview($0) }
        
        [notFoundImageView,
         notFoundLabel].forEach{ notFoundStackView.addArrangedSubview($0) }
    }
    
    override func configureConstraints() {
        let horizontalInset = 24
        
        addButtonView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(26)
            $0.horizontalEdges.equalToSuperview().inset(horizontalInset)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(addButtonView.snp.bottom).offset(26)
            $0.horizontalEdges.equalToSuperview().inset(horizontalInset)
            $0.bottom.equalToSuperview()
        }
        
        notFoundStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        notFoundImageView.snp.makeConstraints {
            $0.width.equalTo(192)
            $0.height.equalTo(98)
        }
    }
    
    func isNotFound(_ isNotFound: Bool) {
        if isNotFound {
            tableView.isHidden = true
            notFoundStackView.isHidden = false
        } else {
            tableView.isHidden = false
            notFoundStackView.isHidden = true
        }
    }
}
