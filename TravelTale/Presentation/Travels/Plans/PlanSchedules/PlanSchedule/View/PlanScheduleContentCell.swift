//
//  PlanScheduleContentCell.swift
//  TravelTale
//
//  Created by 김정호 on 6/8/24.
//

import UIKit
import FloatingPanel

final class PlanScheduleContentCell: BaseTableViewCell {
    
    // MARK: - properties
    static let identifier = String(describing: PlanScheduleContentCell.self)
    
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
        $0.configureLabel(color: .gray70, font: .pretendard(size: 16, weight: .semibold))
    }
    
    let optionButton = UIButton().then {
        $0.setImage(.planDetailsCellEllipsis, for: .normal)
        $0.showsMenuAsPrimaryAction = true
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
        
        numberLabel.isHidden = false
        titlePlanLabel.isHidden = false
        schedulePlanLabel.isHidden = false
        placePlanLabel.isHidden = false
        memoPlanLabel.isHidden = false
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
            $0.verticalEdges.equalToSuperview()
            $0.leading.equalToSuperview().offset(30)
            $0.width.equalTo(0.8)
        }
        
        numberLabel.snp.makeConstraints {
            $0.centerX.equalTo(verticalLineView)
            $0.centerY.equalTo(basedView)
            $0.size.equalTo(20)
        }
        
        basedView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(4)
            $0.leading.equalTo(verticalLineView.snp.trailing).offset(26)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        contentStackView.snp.makeConstraints {
            $0.verticalEdges.leading.equalToSuperview().inset(12)
            $0.trailing.equalTo(optionButton.snp.leading).inset(12)
        }
        
        memoLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(12)
            $0.horizontalEdges.equalToSuperview().inset(12)
        }
        
        optionButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview()
            $0.width.equalTo(30)
        }
    }
    
    func bind(state: FloatingPanelState, schedule: Schedule, index: Int) {
        if let externalMemo = schedule.externalMemo {
            memoLabel.text = externalMemo
            
            remakeScheduleConstraints(state: state, isExternalMemo: true)
        } else {
            numberLabel.text = String(index)
            
            titlePlanLabel.text = schedule.title
            
            if let date = schedule.date {
                schedulePlanLabel.text = "일정  |  \(dateFormat(date: date)) ~"
            }
            
            if let address = schedule.address, !address.isEmpty {
                placePlanLabel.text = "장소  |  \(address)"
            }
            
            if let memo = schedule.internalMemo, !memo.isEmpty {
                memoPlanLabel.text = "메모  |  \(memo)"
            }
            
            remakeScheduleConstraints(state: state, isExternalMemo: false)
        }
    }
    
    func remakeScheduleConstraints(state: FloatingPanelState, isExternalMemo: Bool) {
        if isExternalMemo {
            numberLabel.isHidden = true
            titlePlanLabel.isHidden = true
            schedulePlanLabel.isHidden = true
            placePlanLabel.isHidden = true
            memoPlanLabel.isHidden = true
        } else {
            switch state {
            case .full:
                schedulePlanLabel.isHidden = false
                placePlanLabel.isHidden = false
                memoPlanLabel.isHidden = (memoPlanLabel.text == nil) ? true : false
            default:
                schedulePlanLabel.isHidden = true
                placePlanLabel.isHidden = true
                memoPlanLabel.isHidden = true
            }
        }
    }
}

extension PlanScheduleContentCell {
    func dateFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "a hh:mm"
        
        return formatter.string(from: date)
    }
}
