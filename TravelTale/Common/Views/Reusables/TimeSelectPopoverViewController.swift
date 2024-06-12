//
//  TimeSelectPopover.swift
//  TravelTale
//
//  Created by Kinam on 6/7/24.
//

import UIKit

final class TimeSelectPopoverViewController: BaseViewController {
    
    // MARK: - properties
    private let timeSelectPopoverView = PopoverView()
    
    private let hours: [String] = {
        return (1...12).map { "\($0)"}
    }()
    
    private let minitues: [String] = {
        return (1...60).map { "\($0)"}
    }()
    
    private let ampm: [String] = ["AM", "PM"]
    
    // MARK: - life cycles
    override func loadView() {
        view = timeSelectPopoverView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - methods
    override func configureDelegate() {
        timeSelectPopoverView.pickerView.delegate = self
        timeSelectPopoverView.pickerView.dataSource = self
    }
    
    override func configureAddTarget() {
        timeSelectPopoverView.leftBtn.addTarget(self, action: #selector(tappedcancelBtn), for: .touchUpInside)
        timeSelectPopoverView.rightBtn.addTarget(self, action: #selector(tappedOkBtn), for: .touchUpInside)
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
extension TimeSelectPopoverViewController: UIPickerViewDelegate {
    // TODO: 값이 선택 된 후 로직 구현
}

extension TimeSelectPopoverViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return days.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return days[row]
    }
}
