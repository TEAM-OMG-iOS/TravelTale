//
//  PlanScheduleEditMemoViewController.swift
//  TravelTale
//
//  Created by Kinam on 6/21/24.
//

import UIKit

class PlanScheduleEditMemoViewController: BaseViewController {
    
    // MARK: - properties
    private let memoView = PlanScheduleAddEditMemo()
    
    private let realmManager = RealmManager.shared
    
    var schedule: Schedule? = nil
    
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
        navigationItem.title = "메모 수정"
        navigationItem.leftBarButtonItem = memoView.backButton
    }
    
    private func configureBackAlert(navigationController: UINavigationController?) {
        let alert = UIAlertController(title: "뒤로가기", message: "지금까지 작성된 내용이 삭제됩니다. 이전으로 이동하시겠습니까?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .default) {_ in
            navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        self.present(alert, animated: true)
    }
    
    @objc private func tapBackButton() {
        configureBackAlert(navigationController: navigationController)
    }
    
    @objc private func tapCompleteButton() {
        realmManager.updateMemo(schedule: schedule!, newMemo: memoView.memoTV.text)
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - extensions
extension PlanScheduleEditMemoViewController: UITextViewDelegate {
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
