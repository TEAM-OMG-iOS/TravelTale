//
//  TravelRenewCalendarView.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/12/24.
//

import UIKit
import HorizonCalendar

final class TravelRenewCalendarView: BaseView {
    
    // MARK: - properties
    let inputTitleLabel = UILabel().then {
        $0.configureLabel(color: .blueBlack100,
                          font: .pretendard(size: 18, weight: .semibold),
                          text: "여행 날짜를 선택해주세요")
    }
    
    let okButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .pretendard(size: 18, weight: .bold)
        $0.configureView(color: .green10,
                         cornerRadius: 24)
    }
    
    // MARK: - methods
    override func configureUI() {
        super.configureUI()
    }
    
    override func configureHierarchy() {
        
        [inputTitleLabel,
         okButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        
        inputTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(56)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(20)
        }
        
        okButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
    }
}
