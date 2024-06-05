//
//  MemoAdditionView.swift
//  TravelTale
//
//  Created by Kinam on 6/5/24.
//

import UIKit
import SnapKit
import Then

class MemoAdditionView: BaseView {

    // MARK: - properties
    let memoView = UIView().then {
        $0.backgroundColor = .gray10
        $0.layer.cornerRadius = 20
    }
    
    let memoTitle = UILabel().then {
        $0.text = "메모"
        $0.font = UIFont(name: "Pretendard-Bold", size: 16)
    }
    
    let memoTF = UITextView().then {
        $0.textAlignment = .natural
        $0.backgroundColor = .clear
        $0.text = "여기에 메모를 입력해보세요"
    }
    
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
        
        [memoTitle, memoTF].forEach {
            self.memoView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        memoView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(20)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            $0.bottom.lessThanOrEqualTo(safeAreaLayoutGuide).inset(50)
            $0.height.equalTo(300)
//            $0.height.greaterThanOrEqualTo(260)
        }
        
        memoTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.leading.equalToSuperview().offset(15)
        }
        memoTitle.setContentHuggingPriority(.init(rawValue: 999), for: .vertical)
        
        memoTF.snp.makeConstraints {
            $0.top.equalTo(memoTitle.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - extensions
}
