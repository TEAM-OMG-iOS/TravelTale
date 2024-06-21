//
//  MemoAdditionViewController.swift
//  TravelTale
//
//  Created by Kinam on 6/5/24.
//

import UIKit

final class PlanScheduleAddMemoViewController: BaseViewController {
    
    // MARK: - properties
    private let memoView = PlanScheduleMemoView()
    
    // MARK: - life cycles
    override func loadView() {
        view = memoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAddTarget()
        configureNavigationBar()
    }
    
    // MARK: - methods
    override func configureDelegate() {
        memoView.memoTV.delegate = self
    }
    
    override func configureAddTarget() {
        memoView.completeBtn.addTarget(self, action: #selector(tapCompleteButton), for: .touchUpInside)
        memoView.backButton.target = self
        memoView.backButton.action = #selector(tapBackButton)
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "메모 추가"
        navigationItem.leftBarButtonItem = memoView.backButton
    }
    
    @objc private func tapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func tapCompleteButton() {
        navigationController?.popViewController(animated: true)
        // TODO: 메모 데이터 저장 로직 구현
    }
}

// MARK: - extensions
extension PlanScheduleAddMemoViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        memoView.setBeginText(textView: textView)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        memoView.setEndText(textView: textView)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        memoView.checkTextViewContent()
    }
}
