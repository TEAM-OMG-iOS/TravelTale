//
//  PlanScheduleAddMemoViewController.swift
//  TravelTale
//
//  Created by Kinam on 6/5/24.
//

import UIKit

final class PlanScheduleAddMemoViewController: BaseViewController {
    
    // MARK: - properties
    private let memoView = PlanScheduleAddEditMemoView()
    private let realmManager = RealmManager.shared
    private var travel: Travel
    private var selectedDay: String?
    
    // MARK: - life cycles
    override func loadView() {
        view = memoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAddTarget()
        configureNavigationBar()
    }
    
    init(travel: Travel) {
        self.travel = travel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    private func configureBackAlert(navigationController: UINavigationController?) {
        let alert = UIAlertController(title: "뒤로가기", message: """
이전으로 돌아가면 작성 내용이 저장되지 않습니다.
정말 돌아가시겠습니까?
""", preferredStyle: .alert)
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
        realmManager.createMemo(day: selectedDay!, travel: travel, memo: memoView.memoTV.text)
        navigationController?.popViewController(animated: true)
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
