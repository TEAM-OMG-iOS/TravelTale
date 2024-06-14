//
//  TravelAdditionView2.swift
//  TravelTale
//
//  Created by Kinam on 6/6/24.
//

import UIKit

final class ScheduleCreateView: BaseView {
    
    // MARK: - properties
    let backButton = UIBarButtonItem().then {
        $0.style = .done
        $0.image = UIImage(systemName: "chevron.left")
        $0.tintColor = .gray90
    }
    
    private let loadingBackBar = UIView().then {
        $0.configureView(color: .gray10, cornerRadius: 4)
    }
    
    private var loadingBar = UIView().then {
        $0.configureView(color: .green80, cornerRadius: 4)
    }
    
    private let viewLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 18, weight: .semibold), text: "일정을 생성해주세요")
    }
    
    private let placeView = UIView().then {
        $0.configureView(color: .gray5, cornerRadius: 20)
    }
    
    private let placeTitle = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 16, weight: .bold), text: "장소")
    }
    
    private let placeContents = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 16, weight: .regular), text: "설빙 석촌호수 동호점")
    }
    
    private let scheduleView = UIView().then {
        $0.configureView(color: .gray5, cornerRadius: 20)
    }
    
    let scheduleBtn = UIButton().then {
        $0.configureView(color: .clear)
    }
    
    private let scheduleTitle = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 16, weight: .bold), text: "일정")
    }
    
    let scheduleContents = UILabel().then {
        $0.configureLabel(color: .gray80, font: .pretendard(size: 16, weight: .regular), text: "일정을 선택하세요")
    }
    
    private let startTimeView = UIView().then {
        $0.configureView(color: .gray5, cornerRadius: 20)
    }
    
    let startTiemBtn = UIButton().then {
        $0.configureView(color: .clear)
    }
    
    private let startTimeTitle = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 16, weight: .bold), text: "시작 시간")
    }
    
    let startTimeContents = UILabel().then {
        $0.configureLabel(color: .gray80, font: .pretendard(size: 16, weight: .regular), text: "시간을 선택하세요")
    }
    
    private let memoView = UIView().then {
        $0.configureView(color: .gray5, cornerRadius: 20)
    }
    
    private let memoTitle = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 16, weight: .bold), text: "메모")
    }
    
    let memoTV = UITextView().then {
        $0.text = "메모를 입력하세요"
        $0.textColor = .gray80
        $0.font = .pretendard(size: 16, weight: .regular)
        $0.textAlignment = .natural
        $0.backgroundColor = .clear
    }
    
    private let btnStackView = UIStackView().then {
        $0.configureView(color: .clear)
        $0.axis = .horizontal
        $0.spacing = 15
    }
    
    let cancelBtn = GrayButton().then {
        $0.configureButton(fontColor: .white, font: .pretendard(size: 18, weight: .semibold), text: "취소")
    }
    
    let nextBtn = GreenButton().then {
        $0.configureButton(fontColor: .white, font: .pretendard(size: 18, weight: .semibold), text: "일정 생성하러 가기")
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        [loadingBackBar, viewLabel, placeView, scheduleView, startTimeView, memoView ,btnStackView].forEach {
            self.addSubview($0)
        }
        
        [loadingBar].forEach {
            self.loadingBackBar.addSubview($0)
        }
        
        [placeTitle, placeContents].forEach {
            self.placeView.addSubview($0)
        }
        
        [scheduleBtn, scheduleTitle, scheduleContents].forEach {
            self.scheduleView.addSubview($0)
        }
        
        [startTiemBtn ,startTimeTitle, startTimeContents].forEach {
            self.startTimeView.addSubview($0)
        }
        
        [memoTitle, memoTV].forEach {
            self.memoView.addSubview($0)
        }
        
        [cancelBtn, nextBtn].forEach {
            self.btnStackView.addArrangedSubview($0)
        }
    }
    
    override func configureConstraints() {
        loadingBackBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(18)
            $0.height.equalTo(8)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(19.5)
        }
        
        loadingBar.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.verticalEdges.equalToSuperview()
            $0.height.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
        }
        
        viewLabel.snp.makeConstraints {
            $0.top.equalTo(loadingBackBar.snp.bottom).offset(56)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(24)
        }
        
        placeView.snp.makeConstraints {
            $0.top.equalTo(viewLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
        
        placeTitle.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        placeContents.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        scheduleView.snp.makeConstraints {
            $0.top.equalTo(placeView.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(placeView.snp.horizontalEdges)
            $0.height.equalTo(placeView.snp.height)
        }
        
        scheduleBtn.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scheduleTitle.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        scheduleContents.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        startTimeView.snp.makeConstraints {
            $0.top.equalTo(scheduleView.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(scheduleView.snp.horizontalEdges)
            $0.height.equalTo(scheduleView.snp.height)
        }
        
        startTiemBtn.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        startTimeTitle.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        startTimeContents.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        memoView.snp.makeConstraints {
            $0.top.equalTo(startTimeView.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(startTimeView.snp.horizontalEdges)
            $0.bottom.greaterThanOrEqualTo(btnStackView.snp.top).offset(-20)
        }
        
        memoTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        memoTV.snp.makeConstraints {
            $0.top.equalTo(memoTitle.snp.bottom).offset(4)
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview()
        }
        
        btnStackView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(25)
        }
        
        cancelBtn.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.verticalEdges.equalToSuperview().inset(5)
            $0.width.equalTo(110)
        }
        
        nextBtn.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.verticalEdges.equalToSuperview().inset(5)
            $0.width.equalTo(228)
        }
    }
    
    func startLoadingAnimation() {
        self.loadingBar.snp.remakeConstraints {
            $0.leading.equalToSuperview()
            $0.verticalEdges.equalToSuperview()
            $0.centerY.equalToSuperview()
            let fullwidth = loadingBackBar.frame.size.width
            $0.width.equalTo(fullwidth)
        }
        
        UIView.animate(withDuration: 1.0, delay: 0, animations: {
            self.layoutIfNeeded()
        })
    }
    
    func setBeginText(textView: UITextView) {
        if textView.textColor == .gray80 {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func setEndText(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "메세지를 입력하세요"
            textView.textColor = .gray80
        }
    }
    
    func checkBlackText() {
        var scheduleIsBlack = false
        var startTimeIsBlack = false
        
        if scheduleContents.text != "일정을 선택하세요" {
            scheduleContents.textColor = .black
            scheduleIsBlack = true
        } else {
            scheduleContents.textColor = .gray80
        }
        
        if startTimeContents.text != "시간을 선택하세요" {
            startTimeContents.textColor = .black
            startTimeIsBlack = true
        } else {
            startTimeContents.textColor = .gray80
        }
        
        if scheduleIsBlack && startTimeIsBlack {
            nextBtn.isEnabled = true
            nextBtn.backgroundColor = .green100
        } else {
            nextBtn.isEnabled = false
            nextBtn.backgroundColor = .green10
        }
    }
}
