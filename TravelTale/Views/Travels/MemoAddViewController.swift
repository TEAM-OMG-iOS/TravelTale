//
//  MemoAdditionViewController.swift
//  TravelTale
//
//  Created by Kinam on 6/5/24.
//

import UIKit

final class MemoAddViewController: BaseViewController {
    
    // MARK: - properties
    private let memoAddView = MemoAddView()
    
    // MARK: - life cycles
    override func loadView() {
        view = memoAddView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAddTarget()
        configureNavigationBar()
    }
    
    // MARK: - methods
    override func configureDelegate() {
        memoAddView.memoTV.delegate = self
    }
    
    override func configureAddTarget() {
        memoAddView.completeBtn.addTarget(self, action: #selector(tapCompleteButton), for: .touchUpInside)
        memoAddView.backButton.target = self
        memoAddView.backButton.action = #selector(tapBackButton)
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "메모 추가"
        navigationItem.leftBarButtonItem = memoAddView.backButton
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
extension MemoAddViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        memoAddView.setBeginText(textView: textView)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        memoAddView.setEndText(textView: textView)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        memoAddView.checkTextViewContent()
    }
}
