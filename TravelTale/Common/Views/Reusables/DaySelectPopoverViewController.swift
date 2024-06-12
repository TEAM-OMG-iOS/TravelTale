//
//  DaySelectPopover.swift
//  TravelTale
//
//  Created by Kinam on 6/7/24.
//

import UIKit

final class DaySelectPopoverViewController: BaseViewController {
    
    // MARK: - properties
    let daySelectPopoverView = DaySelectPopoverView()
    
    var days: [String] = ["Day 1", "Day 2","Day 3","Day 4"]
    
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
        print("close")
        self.dismiss(animated: true)
        // TODO: - 데이터가 지정되는 로직 구현
    }
}

// MARK: - extensions
extension DaySelectPopoverViewController: UIPickerViewDelegate {
    // TODO: 값이 선택 된 후 로직 구현
}

extension DaySelectPopoverViewController: UIPickerViewDataSource {
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
