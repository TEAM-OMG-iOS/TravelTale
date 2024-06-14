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
    
    let editButton = UIBarButtonItem().then {
        $0.style = .done
        $0.image = UIImage(systemName: "pencil.line")
        $0.tintColor = .gray90
    }
    
    private let travelInfoStackView = UIStackView().then {
        $0.axis = .horizontal
    }
    
    private let provinceLabel = UILabel().then {
        $0.configureView(color: .blueBlack100, clipsToBounds: true, cornerRadius: 10)
        $0.configureLabel(alignment: .center,
                          color: .white,
                          font: .pretendard(size: 12, weight: .medium))
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
    
    let tableView = UITableView(frame: CGRect.zero, style: .grouped).then {
        $0.backgroundColor = .clear
    }
    
    
    // MARK: - methods
    override func configureHierarchy() {
        [travelInfoStackView,
         travelTitleLabel,
         borderLine,
         tableView].forEach { self.addSubview($0) }
        
        [periodLabel,
         provinceLabel].forEach { travelInfoStackView.addArrangedSubview($0) }
    }
    
    override func configureConstraints() {
        let horizontalInset = CGFloat(24)
        
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
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(borderLine.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    func bind(travel: Travel) {
        provinceLabel.text = travel.province ?? "미정"
        periodLabel.text = String(startDate: travel.startDate, endDate: travel.endDate)
        travelTitleLabel.text = travel.title
    }
}
