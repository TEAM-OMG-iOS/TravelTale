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
    private let scheduleCreateView = ScheduleCreateView()
    
    private let dayPopoverVC = DaySelectPopoverViewController()
    
    private let timePopoverVC = TimeSelectPopoverViewController()
    
    // 데이터 모델에 따라 변경될 예정
    var selectedData: Travel? = nil
    
    // MARK: - life cycles
    override func loadView() {
        view = scheduleCreateView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        scheduleCreateView.checkTextViewContent()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        scheduleCreateView.startLoadingAnimation()
    }
    
    // MARK: - methods
    override func configureDelegate() {
        scheduleCreateView.memoTV.delegate = self
    }
    
    override func configureAddTarget() {
        //popoverview
        scheduleCreateView.scheduleBtn.addTarget(self, action: #selector(tappedScheduleBtn), for: .touchUpInside)
        scheduleCreateView.startTiemBtn.addTarget(self, action: #selector(tappedStartTimeBtn), for: .touchUpInside)
        
        //common btn
        scheduleCreateView.cancelBtn.tag = 0
        scheduleCreateView.cancelBtn.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        scheduleCreateView.backButton.tag = 1
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
    
    // MARK: - objc func
    @objc private func handleBackButton(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            navigationController?.popViewController(animated: true)
        case 1:
            navigationController?.popToRootViewController(animated: true)
        default:
            navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: - extensions
extension ScheduleCreateViewController: UIPopoverPresentationControllerDelegate {
    @objc private func tappedScheduleBtn() {
        dayPopoverVC.modalPresentationStyle = .popover
        dayPopoverVC.preferredContentSize = .init(width: 300, height: 200)
        dayPopoverVC.popoverPresentationController?.sourceView = scheduleCreateView.scheduleBtn
        dayPopoverVC.popoverPresentationController?.sourceRect = CGRect(origin: CGPoint(x: scheduleCreateView.scheduleBtn.bounds.midX, y: scheduleCreateView.scheduleBtn.bounds.midY), size: .zero)
        dayPopoverVC.popoverPresentationController?.permittedArrowDirections = .up
        dayPopoverVC.popoverPresentationController?.delegate = self
        present(dayPopoverVC, animated: true)
    }
    
    @objc private func tappedStartTimeBtn() {
        timePopoverVC.modalPresentationStyle = .popover
        timePopoverVC.preferredContentSize = .init(width: 300, height: 200)
        timePopoverVC.popoverPresentationController?.sourceView = scheduleCreateView.startTiemBtn
        timePopoverVC.popoverPresentationController?.sourceRect = CGRect(origin: CGPoint(x: scheduleCreateView.startTiemBtn.bounds.midX, y: scheduleCreateView.startTiemBtn.bounds.midY), size: .zero)
        timePopoverVC.popoverPresentationController?.permittedArrowDirections = .up
        timePopoverVC.popoverPresentationController?.delegate = self
        present(timePopoverVC, animated: true)
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
