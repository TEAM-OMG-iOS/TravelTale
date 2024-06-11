//
//  TravelAddViewController2.swift
//  TravelTale
//
//  Created by Kinam on 6/6/24.
//

import UIKit
import SnapKit

final class ScheduleCreateViewController: BaseViewController {
    // MARK: - properties
    let scheduleCreateView = ScheduleCreateView()
    
    let dayPopoverVC = DaySelectPopover()
    
    // 데이터 모델에 따라 변경될 예정
    var selectedData: Travel? = nil
    
    // MARK: - life cycles
    override func loadView() {
        view = scheduleCreateView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        scheduleCreateView.startLoadingAnimation()
    }
    
    // MARK: - methods
    override func configureDelegate() {
        scheduleCreateView.memoTV.delegate = self
    }
    
    override func configureAddTarget() {
        scheduleCreateView.scheduleBtn.addTarget(self, action: #selector(tappedScheduleBtn), for: .touchUpInside)
        scheduleCreateView.backButton.target = self
        scheduleCreateView.backButton.action = #selector(handleBackButton)
    }
    
    override func bind() {
        // TODO: - 데이터 생성 후 편집 예정
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "내 여행에 추가"
        navigationItem.leftBarButtonItem = scheduleCreateView.backButton
    }
    
    @objc private func handleBackButton() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - extensions
extension ScheduleCreateViewController: UIPopoverPresentationControllerDelegate {
    @objc private func tappedScheduleBtn() {
        dayPopoverVC.modalPresentationStyle = .popover
        dayPopoverVC.preferredContentSize = .init(width: 300, height: 200)
        dayPopoverVC.popoverPresentationController?.sourceView = scheduleCreateView.scheduleBtn
        dayPopoverVC.popoverPresentationController?.sourceRect = CGRect(origin: CGPoint(x: scheduleCreateView.scheduleBtn.bounds.midX, y: scheduleCreateView.scheduleBtn.bounds.midY), size: .zero)
        dayPopoverVC.popoverPresentationController?.permittedArrowDirections = .any
        dayPopoverVC.popoverPresentationController?.delegate = self
        present(dayPopoverVC, animated: true)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}

extension ScheduleCreateViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        scheduleCreateView.setBeginText(textView: textView)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        scheduleCreateView.setEndText(textView: textView)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        scheduleCreateView.checkTextViewContent()
    }
}
