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
    
    let notFoundView = NotFoundView().then {
        $0.setLabel(text: """
생성된 여행이 없습니다.
'새 여행 추가' 버튼을 눌러주세요.
""")
    }
    
    // MARK: - methods
    override func configureUI() {
        super.configureUI()
        addButtonView.configureButton(text: "새 여행 추가")
    }
    
    override func configureHierarchy() {
        [addButtonView,
         tableView,
         notFoundView].forEach { self.addSubview($0) }
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
        
        notFoundView.snp.makeConstraints {
            $0.top.equalTo(tableView)
            $0.horizontalEdges.equalTo(tableView)
            $0.bottom.equalTo(tableView).offset(-80)
        }
    }
    
    func showNotFoundView(_ isNotFound: Bool) {
        if isNotFound {
            notFoundView.isHidden = false
        } else {
            notFoundView.isHidden = true
        }
    }
}
