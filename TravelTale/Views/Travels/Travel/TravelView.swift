//
//  TravelView.swift
//  TravelTale
//
//  Created by 김정호 on 6/3/24.
//

import UIKit

class TravelView: BaseView {
    
    // MARK: - Properties
    
    // segment button
    let segmentButtonStackView = UIStackView()
    let planButton = UIButton()
    let memoryButton = UIButton()
    
    let borderLine = UIView()
    
    // 추가 버튼
    let addButton = UIView()
    let addButtonInnerStackView = UIStackView()
    let circleView = UIView()
    let plusImage = UIImageView()
    let addButtonLabel = UILabel()
    
    let tableView = UITableView()
    
    
    // MARK: - Methods
    
    override func configureUI() {
        super.configureUI()
        
        // segment button
        [planButton,
        memoryButton].forEach {
            $0.configureView(color: .gray10, cornerRadius: 25)
            $0.titleLabel?.snp.makeConstraints {
                $0.horizontalEdges.equalToSuperview().inset(12)
            }
        }
        
        planButton.configureButton(fontColor: .gray80,font: .oaGothic(size: 24, weight: .heavy), text: "Plan")
        memoryButton.configureButton(fontColor: .gray80,font: .oaGothic(size: 24, weight: .heavy), text: "Memory")
        
        segmentButtonStackView.axis = .horizontal
        segmentButtonStackView.spacing = 16
        
        
        borderLine.backgroundColor = .gray20
        borderLine.snp.makeConstraints {
            $0.height.equalTo(1)
        }
        
        // 추가 버튼
        addButton.configureView(color: .green10, cornerRadius: 24)
        
        addButtonInnerStackView.axis = .horizontal
        addButtonInnerStackView.spacing = 12
        
        circleView.backgroundColor = .green100
        circleView.layer.cornerRadius = 10
        circleView.snp.makeConstraints {
            $0.size.equalTo(20)
        }
        
        plusImage.image = UIImage(
            systemName: "plus",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 12, weight: .bold))
        plusImage.tintColor = .blueBlack100
        
        addButtonLabel.textColor = .blueBlack100
        addButtonLabel.font = .pretendard(size: 18, weight: .semibold)
        
        
    }
    
    
    override func configureHierarchy() {
        
        [segmentButtonStackView,
         borderLine,
         addButton,
         tableView].forEach {
            self.addSubview($0)
        }
        
        [planButton, 
         memoryButton].forEach {
            segmentButtonStackView.addArrangedSubview($0)
        }
        
        addButton.addSubview(addButtonInnerStackView)
        
        [circleView,
         addButtonLabel].forEach {
            addButtonInnerStackView.addArrangedSubview($0)
        }
        
        circleView.addSubview(plusImage)
    }
    
    
    override func configureConstraints() {
        
        let horizontalInset = 20
        
        segmentButtonStackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            $0.leading.equalToSuperview().offset(horizontalInset)
            $0.height.equalTo(43)
        }
        
        borderLine.snp.makeConstraints {
            $0.top.equalTo(segmentButtonStackView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview()
        }
        
        addButton.snp.makeConstraints {
            $0.top.equalTo(borderLine.snp.bottom).offset(26)
            $0.horizontalEdges.equalToSuperview().inset(horizontalInset)
            $0.height.equalTo(52)
        }
        
        addButtonInnerStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        plusImage.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(addButton.snp.bottom).offset(26)
            $0.horizontalEdges.equalToSuperview().inset(horizontalInset)
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
