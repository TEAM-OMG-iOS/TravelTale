//
//  DaySelectPopover.swift
//  TravelTale
//
//  Created by Kinam on 6/7/24.
//

import Foundation
import UIKit
import SnapKit

final class DaySelectPopover: BaseViewController {
    
    // MARK: - properties
    var days: [String] = ["Day 1", "Day 2","Day 3","Day 4"]
    
    let daySelectView = UIView().then {
        $0.configureView(color: .lightGray)
    }
    
    let leftBtn = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.tintColor = .gray70
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
    }
    
    let daySelectTitle = UILabel().then {
        $0.textAlignment = .center
        $0.font = UIFont(name: "Pretendard-Bold", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.textColor = .black
    }
    
    let rightBtn = UIButton().then {
        $0.setTitle("확인", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        $0.tintColor = .blue
    }
    
    let pickerView = UIPickerView()
    
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.backgroundColor = .white
    }
    
    // MARK: - methods
    override func configureStyle() {
        [daySelectView, pickerView].forEach {
            self.view.addSubview($0)
        }
        
        [leftBtn, daySelectTitle, rightBtn].forEach {
            self.daySelectView.addSubview($0)
        }
        
        daySelectView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        leftBtn.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
        }
        
        daySelectTitle.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        rightBtn.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
        }
        
        pickerView.snp.makeConstraints {
            $0.top.equalTo(daySelectView.snp.bottom)
            $0.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    override func configureDelegate() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    override func configureAddTarget() { }
    
    override func bind() { }
    
    @objc private func tappedcancelBtn() {
        navigationController?.dismiss(animated: true)
    }
    
    @objc private func tappedOkBtn() {
        navigationController?.dismiss(animated: true)
    }
}

// MARK: - extensions
extension DaySelectPopover: UIPickerViewDelegate {
    
}

extension DaySelectPopover: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return days.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return days[row]
    }
    
    
}
