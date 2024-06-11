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
    override func configureStyle() {
        
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
    // TODO: 값이 선택 된 후 로직 구현
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
