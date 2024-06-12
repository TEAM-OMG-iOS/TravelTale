//
//  TimeSelectPopoverView.swift
//  TravelTale
//
//  Created by Kinam on 6/12/24.
//

import UIKit

final class TimeSelectPopoverView: BaseView {
    
    // MARK: - properties
    private let daySelectView = UIView().then {
        $0.configureView(color: .gray5)
    }
    
    let leftBtn = UIButton().then {
        $0.configureButton(fontColor: .gray80 ,font: .pretendard(size: 16, weight: .regular), text: "취소")
    }
    
    private let title = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 16, weight: .semibold), text: "일정 선택")
    }
    
    let rightBtn = UIButton().then {
        $0.configureButton(fontColor: .systemBlue ,font: .pretendard(size: 16, weight: .regular), text: "확인")
    }
    
    let datepickerView = UIDatePicker().then {
        $0.datePickerMode = .time
        $0.preferredDatePickerStyle = .wheels
        $0.locale = Locale(identifier: "ko-KR")
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        [datepickerView, daySelectView].forEach {
            self.addSubview($0)
        }
        
        [leftBtn, title, rightBtn].forEach {
            daySelectView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        daySelectView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
        
        datepickerView.snp.makeConstraints {
            $0.top.equalTo(daySelectView.snp.bottom)
            $0.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        leftBtn.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(14)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        title.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        rightBtn.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(14)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(20)
        }
    }
}

