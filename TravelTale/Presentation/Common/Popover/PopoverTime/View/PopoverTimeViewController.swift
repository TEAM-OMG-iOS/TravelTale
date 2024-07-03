//
//  PopoverTimeViewController.swift
//  TravelTale
//
//  Created by Kinam on 6/7/24.
//

import UIKit

final class PopoverTimeViewController: BaseViewController {
    
    // MARK: - properties
    private let timeSelectPopoverView = PopoverTimeView()
    
    // MARK: - life cycles
    override func loadView() {
        view = timeSelectPopoverView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - methods
    override func configureAddTarget() {
        timeSelectPopoverView.leftBtn.addTarget(self, action: #selector(tappedcancelBtn), for: .touchUpInside)
        timeSelectPopoverView.rightBtn.addTarget(self, action: #selector(tappedOkBtn), for: .touchUpInside)
    }

    @objc private func tappedcancelBtn() {
        self.dismiss(animated: true)
    }
    
    @objc private func tappedOkBtn() {
        let selectedTime = timeSelectPopoverView.datepickerView.date
        NotificationCenter.default.post(name: .selectedTimeUpdated, object: nil, userInfo: ["selectedTime": selectedTime])
        self.dismiss(animated: true)
    }
}

// MARK: - extensions
extension Notification.Name {
    static let selectedTimeUpdated = Notification.Name("selectedTimeUpdated")
}
