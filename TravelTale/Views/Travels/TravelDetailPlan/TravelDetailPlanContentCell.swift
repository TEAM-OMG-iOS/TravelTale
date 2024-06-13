//
//  TravelDetailPlanContentCell.swift
//  TravelTale
//
//  Created by 김정호 on 6/8/24.
//

import UIKit
import FloatingPanel

final class TravelDetailPlanContentCell: BaseTableViewCell {
    
    // MARK: - properties
    static let identifier = "TravelDetailPlanContentCell"
    
    private let verticalLineView = UIView().then {
        $0.configureView(color: .black)
    }
    
    private let numberLabel = UILabel().then {
        $0.configureView(color: .black, clipsToBounds: true, cornerRadius: 10)
        $0.configureLabel(alignment: .center, color: .white, font: .oaGothic(size: 12, weight: .heavy))
    }
    
    private let basedView = UIView().then {
        $0.configureView(clipsToBounds: true, cornerRadius: 10)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray10.cgColor
    }
    
    private let titlePlanLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 16, weight: .semibold))
    }
    
    private let schedulePlanLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 12, weight: .medium))
    }
    
    private let placePlanLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 12, weight: .medium))
    }
    
    private let memoPlanLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 12, weight: .medium))
    }
    
    private let memoLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 16, weight: .semibold))
    }
    
    let optionButton = UIButton().then {
        $0.setImage(.planDetailsCellEllipsis, for: .normal)
    }
    
    private let contentStackView = UIStackView().then {
        $0.spacing = 12
        $0.axis = .vertical
        $0.alignment = .leading
        $0.distribution = .equalSpacing
    }
    
    // MARK: - life cycles
    override func prepareForReuse() {
        super.prepareForReuse()
        
        numberLabel.text = nil
        titlePlanLabel.text = nil
        schedulePlanLabel.text = nil
        placePlanLabel.text = nil
        memoPlanLabel.text = nil
        memoLabel.text = nil
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        self.contentView.addSubview(verticalLineView)
        self.contentView.addSubview(numberLabel)
        self.contentView.addSubview(basedView)
        self.basedView.addSubview(contentStackView)
        self.basedView.addSubview(memoLabel)
        self.basedView.addSubview(optionButton)
        self.contentStackView.addArrangedSubview(titlePlanLabel)
        self.contentStackView.addArrangedSubview(schedulePlanLabel)
        self.contentStackView.addArrangedSubview(placePlanLabel)
        self.contentStackView.addArrangedSubview(memoPlanLabel)
    }
    
    override func configureConstraints() {
        verticalLineView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(30)
            $0.width.equalTo(0.8)
        }
        
        numberLabel.snp.makeConstraints {
            $0.centerX.equalTo(verticalLineView.snp.centerX)
            $0.centerY.equalTo(basedView.snp.centerY)
            $0.size.equalTo(20)
        }
        
        basedView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(4)
            $0.leading.equalTo(verticalLineView.snp.trailing).offset(26)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        contentStackView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(12)
            $0.trailing.equalTo(optionButton.snp.leading).inset(12)
        }
        
        memoLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(12)
        }
        
        optionButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(14)
            $0.trailing.equalToSuperview().offset(-12)
        }
    }
}
