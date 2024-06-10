//
//  MemoAdditionViewController.swift
//  TravelTale
//
//  Created by Kinam on 6/5/24.
//

import UIKit

class MemoAddViewController: BaseViewController {
    
    // MARK: - properties
    let memoAddView = MemoAddView()
    
    // MARK: - life cycles
    override func loadView() {
        super.loadView()
        view = memoAddView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAddTarget()
        configureNavigationBar()
        checkTextViewContent()
    }
    
    // MARK: - methods
    override func configureStyle() { }
    
    override func configureDelegate() {
        memoAddView.memoTV.delegate = self
    }
    
    override func configureAddTarget() { }
    
    override func bind() { }
    
    private func setAddTarget() {
        memoAddView.completeBtn.addTarget(self, action: #selector(tapCompleteButton), for: .touchUpInside)
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "메모 추가"
        
        let xbutton = XButton()
        xbutton.addTarget(self, action: #selector(tapBackButton), for: .touchUpInside)
        let exitButtonItem = UIBarButtonItem(customView: xbutton)
        navigationItem.rightBarButtonItem = exitButtonItem
        
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.titleTextAttributes = [
                NSAttributedString.Key.font: UIFont.oaGothic(size: 18, weight: .heavy),
                NSAttributedString.Key.foregroundColor: UIColor.black
            ]
        }
    }
    
    @objc private func tapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func tapCompleteButton() {
        navigationController?.popViewController(animated: true)
        // MARK: - TODO 메모 데이터 저장 로직 구현
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func checkTextViewContent() {
        let text = memoAddView.memoTV.text ?? ""
        let isPlaceholder = text == "메세지를 입력하세요"
        
        if isPlaceholder || text.isEmpty {
            memoAddView.completeBtn.isEnabled = false
            memoAddView.completeBtn.backgroundColor = .green10
        } else {
            memoAddView.completeBtn.isEnabled = true
            memoAddView.completeBtn.backgroundColor = .green100

        }
    }
}
// MARK: - extensions
extension MemoAddViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "메세지를 입력하세요"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        checkTextViewContent()
    }
}
