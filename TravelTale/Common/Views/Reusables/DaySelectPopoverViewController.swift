//
//  DaySelectPopover.swift
//  TravelTale
//
//  Created by Kinam on 6/7/24.
//

import UIKit

final class DaySelectPopoverViewController: BaseViewController {
    
    // MARK: - properties
    private let daySelectPopoverView = DaySelectPopoverView()
    
    // TODO: - 데이터 변경 시 수정 예정
    private let days: [String] = ["Day 1", "Day 2","Day 3","Day 4"]
    
    var selectedDays: String?
    
    // MARK: - life cycles
    override func loadView() {
        view = daySelectPopoverView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - methods
    override func configureDelegate() {
        daySelectPopoverView.pickerView.delegate = self
        daySelectPopoverView.pickerView.dataSource = self
    }
    
    override func configureAddTarget() {
        daySelectPopoverView.leftBtn.addTarget(self, action: #selector(tappedcancelBtn), for: .touchUpInside)
        daySelectPopoverView.rightBtn.addTarget(self, action: #selector(tappedOkBtn), for: .touchUpInside)
    }

    // MARK: - objc func
    @objc private func tappedcancelBtn() {
        print("close")
        self.dismiss(animated: true)
    }
    
    @objc private func tappedOkBtn() {
        guard let selectedDays = selectedDays else { return }
        NotificationCenter.default.post(name: .selectedDaysUpdated, object: nil, userInfo: ["selectedDays": selectedDays])
        self.dismiss(animated: true)
    }
}

// MARK: - extensions
extension DaySelectPopoverViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return days[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedDays = days[row]
    }
}

extension DaySelectPopoverViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return days.count
    }
}

extension Notification.Name {
    static let selectedDaysUpdated = Notification.Name("selectedDaysUpdated")
}
