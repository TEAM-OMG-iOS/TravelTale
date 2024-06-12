//
//  TravelDetailPlanFooterCell.swift
//  TravelTale
//
//  Created by 김정호 on 6/11/24.
//

import UIKit

final class TravelDetailPlanFooterCell: BaseTableViewCell {
    
    // MARK: - properties
    private let verticalLineView = UIView().then {
        $0.configureView(color: .black)
    }
    
    private let plusImageBaseView = UIView().then {
        $0.configureView(color: .black, clipsToBounds: true, cornerRadius: 10)
    }
    
    private let plusImageView = UIImageView().then {
        $0.image = .planDetailsPlus
    }
    
    private let placeAddButton = UIButton().then {
        $0.configureView(color: .green100, clipsToBounds: true, cornerRadius: 22)
        $0.configureButton(fontColor: .white, font: .pretendard(size: 18, weight: .bold), text: "장소 추가")
    }
    
    private let memoAddButton = UIButton().then {
        $0.configureView(color: .white, clipsToBounds: true, cornerRadius: 22)
        $0.configureButton(fontColor: .green100, font: .pretendard(size: 18, weight: .bold), text: "메모 추가")
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.green100.cgColor
    }
    
    private let buttonStackView = UIStackView().then {
        $0.spacing = 16
        $0.distribution = .fillEqually
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        self.contentView.addSubview(verticalLineView)
        self.contentView.addSubview(plusImageBaseView)
        self.contentView.addSubview(buttonStackView)
        self.plusImageBaseView.addSubview(plusImageView)
        self.buttonStackView.addArrangedSubview(placeAddButton)
        self.buttonStackView.addArrangedSubview(memoAddButton)
    }
    
    override func configureConstraints() {
        verticalLineView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(30)
            $0.width.equalTo(0.8)
        }
        
        plusImageBaseView.snp.makeConstraints {
            $0.centerX.equalTo(verticalLineView.snp.centerX)
            $0.centerY.equalTo(buttonStackView.snp.centerY)
            $0.size.equalTo(20)
        }
        
        plusImageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(4)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(16)
            $0.leading.equalTo(verticalLineView.snp.trailing).offset(26)
            $0.bottom.equalToSuperview().offset(-24)
            $0.height.equalTo(44)
        }
    }
}
