//
//  PopoverDayViewController.swift
//  TravelTale
//
//  Created by Kinam on 6/7/24.
//

import UIKit

final class PopoverDayViewController: BaseViewController {
    
    // MARK: - properties
    private let daySelectPopoverView = PopoverDayView()
    
    private var travel: Travel
    private var data: [String]
    
    var selectedDays: String?
    
    // MARK: - life cycles
    init(data: [String], travel: Travel) {
        self.data = data
        self.travel = travel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = daySelectPopoverView
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
    
    @objc private func tappedcancelBtn() {
        self.dismiss(animated: true)
    }
    
    @objc private func tappedOkBtn() {
        guard let selectedDays = selectedDays else { return }
        NotificationCenter.default.post(name: .selectedDaysUpdated, object: nil, userInfo: ["selectedDays": selectedDays])
        self.dismiss(animated: true)
    }
}

// MARK: - extensions
extension PopoverDayViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedDays = data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 35.0
    }
}

extension PopoverDayViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
}

extension Notification.Name {
    static let selectedDaysUpdated = Notification.Name("selectedDaysUpdated")
}
