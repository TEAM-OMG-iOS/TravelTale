//
//  MemoAdditionView.swift
//  TravelTale
//
//  Created by Kinam on 6/5/24.
//

import UIKit
import SnapKit
import Then

class MemoAddView: BaseView {

    // MARK: - properties
    let memoView = UIView().then {
        $0.configureView(color: .gray10, cornerRadius: 20)
    }
    
    let memoTitle = UILabel().then {
        $0.configureLabel(font: UIFont(name: "Pretendard-Bold", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .bold), text: "메모")
    }
    
    let memoTV = UITextView().then {
        $0.textAlignment = .natural
        $0.backgroundColor = .clear
        $0.text = "메세지를 입력하세요"
        $0.textColor = .lightGray
    }
    
    let completeBtn = GreenButton().then {
        $0.configureButton(fontColor: .white, font: UIFont(name: "Pretendard-SemiBold", size: 18) ?? UIFont.systemFont(ofSize: 18, weight: .semibold), text: "완료")
    }
    
    let naviTitle = UILabel()
    
    // MARK: - life cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        configureHierarchy()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - methods
    override func configureUI() {
        self.backgroundColor = .white
    }
    
    override func configureHierarchy() {
        [memoView].forEach {
            self.addSubview($0)
        }
        
        [memoTitle, memoTV, completeBtn].forEach {
            self.memoView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        memoView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(20)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
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
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(15)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(52)
        }
    }
}
