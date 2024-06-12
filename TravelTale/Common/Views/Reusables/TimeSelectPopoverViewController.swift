//
//  TimeSelectPopover.swift
//  TravelTale
//
//  Created by Kinam on 6/7/24.
//

import UIKit

final class TimeSelectPopoverViewController: BaseViewController {
    
    // MARK: - properties
    private let timeSelectPopoverView = TimeSelectPopoverView()
    
    // MARK: - life cycles
    override func loadView() {
        view = timeSelectPopoverView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - methods
    override func configureDelegate() {
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
