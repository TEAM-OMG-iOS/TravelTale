//
//  TravelMemoryDetailView.swift
//  TravelTale
//
//  Created by 유림 on 6/13/24.
//

import UIKit

class TravelMemoryDetailView: BaseView {
    
    // MARK: - properties
    let backButton = UIBarButtonItem().then {
        $0.style = .done
        $0.image = UIImage(systemName: "chevron.left")
        $0.tintColor = .gray90
      }
    
    private let travelInfoStackView = UIStackView().then {
        $0.axis = .horizontal
    }
    
    private let provinceLabel = UILabel().then {
        $0.configureView(color: .blueBlack100, cornerRadius: 10)
        $0.configureLabel(alignment: .center,
                          color: .gray100,
                          font: .oaGothic(size: 10, weight: .medium))
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private let periodLabel = UILabel().then {
        $0.configureLabel(color: .gray100, font: .oaGothic(size: 10, weight: .medium))
        $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
    
    private let travelTitleLabel = UILabel().then {
        $0.configureLabel(alignment: .left, font: .pretendard(size: 20, weight: .bold))
    }
    
    private let borderLine = UIView().then {
        $0.configureView(color: .gray10)
    }
    
    private let recordLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 14, weight: .medium), numberOfLines: 0)
    }
    
    let tableView = UITableView()
    
    
    // MARK: - methods
    override func configureHierarchy() {
        [travelInfoStackView,
         travelTitleLabel,
         borderLine,
         recordLabel,
         tableView].forEach { self.addSubview($0) }
        
        [provinceLabel,
         periodLabel].forEach { travelInfoStackView.addArrangedSubview($0) }
    }
    
    override func configureConstraints() {
        let phoneWidth = UIScreen.main.bounds.width
        let horizontalInset = CGFloat(20)
        
        travelInfoStackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(horizontalInset)
        }
        
        provinceLabel.snp.makeConstraints {
            $0.height.equalTo(22)
            $0.width.equalTo(38)
        }
        
        travelTitleLabel.snp.makeConstraints {
            $0.top.equalTo(travelInfoStackView.snp.bottom).offset(6)
            $0.horizontalEdges.equalToSuperview().inset(horizontalInset)
        }
        
        borderLine.snp.makeConstraints {
            $0.top.equalTo(travelTitleLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(4)
        }
        
        recordLabel.snp.makeConstraints {
            $0.top.equalTo(borderLine.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(horizontalInset)
        }
    }
    
    func bind(travel: Travel) {
        provinceLabel.text = travel.province ?? "미정"
        periodLabel.text = String(startDate: travel.startDate, endDate: travel.endDate)
        travelTitleLabel.text = travel.title
        recordLabel.text = travel.travelJournal
    }
}
