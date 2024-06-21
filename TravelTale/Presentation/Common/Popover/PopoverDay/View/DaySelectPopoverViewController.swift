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
    
    var day: String?
    
    var travel: Travel?
    
    var data: [String] = [] {
        didSet {
            data = configureData(day: day!, travel: travel!)
        }
    }
    
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
    
    private func configureData(day: String, travel: Travel) -> [String] {
        guard let daysCount = Int(day) else {
            return []
        }
        var results = [String]()
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 mm월 dd일"
        
        for i in 0..<daysCount {
            if let newDate = Calendar.current.date(byAdding: .day, value: i, to: travel.startDate) {
                let dateString = formatter.string(from: newDate)
                results.append("Day \(i + 1) | \(dateString)")
            }
        }
        return results
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
extension DaySelectPopoverViewController: UIPickerViewDelegate {
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

extension DaySelectPopoverViewController: UIPickerViewDataSource {
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
