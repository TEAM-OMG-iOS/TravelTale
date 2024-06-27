//
//  PlanScheduleAddEditMemoView.swift
//  TravelTale
//
//  Created by Kinam on 6/5/24.
//

import UIKit

final class PlanScheduleAddEditMemoView: BaseView {
    
    // MARK: - properties
    let backButton = UIBarButtonItem().then {
        $0.style = .done
        $0.image = UIImage(systemName: "chevron.left")
        $0.tintColor = .gray90
    }
    
    private let memoView = UIView().then {
        $0.configureView(color: .gray10, cornerRadius: 20)
    }
    
    private let memoTitle = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 16, weight: .bold), text: "메모")
    }
    
    let memoTV = UITextView().then {
        $0.configureView(color: .clear)
        $0.textAlignment = .natural
        $0.text = "메세지를 입력하세요"
        $0.textColor = .lightGray
        $0.font = .pretendard(size: 16, weight: .regular)
    }
    
    let completeBtn = GreenButton().then {
        $0.configureButton(fontColor: .white, font: .pretendard(size: 20, weight: .bold), text: "완료")
    }
    
    let alertMessage = """
작성중인 내용이 저장되지 않습니다.
이전으로 돌아가시겠습니까?
"""
    
    // MARK: - methods
    override func configureUI() {
        super.configureUI()
        checkTextViewContent()
    }
    
    override func configureHierarchy() {
        [memoView, completeBtn].forEach {
            self.addSubview($0)
        }
        
        [memoTitle, memoTV].forEach {
            self.memoView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        memoView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(20)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            $0.bottom.lessThanOrEqualTo(safeAreaLayoutGuide).inset(50)
            $0.height.equalTo(300)
        }
        
        memoTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.leading.equalToSuperview().offset(15)
        }
        
        memoTitle.setContentHuggingPriority(.init(rawValue: 999), for: .vertical)
        
        memoTV.snp.makeConstraints {
            $0.top.equalTo(memoTitle.snp.bottom).offset(4)
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(10)
        }
        
        completeBtn.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            $0.height.equalTo(52)
        }
    }
    
    func checkTextViewContent() {
        let text = memoTV.text ?? ""
        let isPlaceholder = text == "메세지를 입력하세요"
        
        if isPlaceholder || text.isEmpty {
            completeBtn.isEnabled = false
            completeBtn.backgroundColor = .green10
        } else {
            completeBtn.isEnabled = true
            completeBtn.backgroundColor = .green100
        }
    }
    
    func setBeginText(textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func setEndText(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "메세지를 입력하세요"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func checkMemo(textColor: UIColor) -> String {
        return textColor == .gray80 ? "" : memoTV.text
    }
}
