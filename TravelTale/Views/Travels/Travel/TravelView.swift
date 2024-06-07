//
//  TravelView.swift
//  TravelTale
//
//  Created by 김정호 on 6/3/24.
//

import UIKit

class TravelView: BaseView {
    
    // MARK: - properties
    private let buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 16
    }
    
    let planButton = UIButton().then {
        $0.configureButton(fontColor: .gray80,font: .oaGothic(size: 24, weight: .heavy), text: "Plan")
    }
    
    let memoryButton = UIButton().then {
        $0.configureButton(fontColor: .gray80,font: .oaGothic(size: 24, weight: .heavy), text: "Memory")
    }
    
    private let borderLine = UIView().then {
        $0.configureView(color: .gray20)
    }
    
    private let convertableView = UIView()
    
    
    // MARK: - methods
    override func configureUI() {
        super.configureUI()
        
        [planButton,
         memoryButton].forEach {
            $0.configureView(color: .gray10, cornerRadius: 25)
            $0.titleLabel?.snp.makeConstraints {
                $0.horizontalEdges.equalToSuperview().inset(12)
            }
        }
    }
    
    override func configureHierarchy() {
        [buttonStackView,
         borderLine,
         convertableView].forEach {
            self.addSubview($0)
        }
        
        [planButton,
         memoryButton].forEach {
            buttonStackView.addArrangedSubview($0)
        }
    }
    
    override func configureConstraints() {
        let horizontalInset = 20
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            $0.leading.equalToSuperview().offset(horizontalInset)
            $0.height.equalTo(43)
        }
        
        borderLine.snp.makeConstraints {
            $0.top.equalTo(buttonStackView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        convertableView.snp.makeConstraints {
            $0.top.equalTo(borderLine.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    func addChildView(_ newView: UIView) {
        convertableView.addSubview(newView)
        newView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func changeButtonUI(tapped button: travelSegment) {
        switch button {
        case .plan:
            planButton.configureButton(
                fontColor: .blueBlack100,
                font: .oaGothic(size: 24, weight: .heavy),
                text: "Plan"
            )
            memoryButton.configureButton(
                fontColor: .gray80,
                font: .oaGothic(size: 24, weight: .heavy),
                text: "Memory"
            )
            
        case .memory:
            planButton.configureButton(
                fontColor: .gray80,
                font: .oaGothic(size: 24, weight: .heavy),
                text: "Plan"
            )
            memoryButton.configureButton(
                fontColor: .blueBlack100,
                font: .oaGothic(size: 24, weight: .heavy),
                text: "Memory"
            )
        }
    }
}
