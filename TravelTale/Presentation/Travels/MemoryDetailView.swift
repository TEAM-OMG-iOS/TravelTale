//
//  TravelMemoryDetailView.swift
//  TravelTale
//
//  Created by 유림 on 6/13/24.
//

import UIKit

final class MemoryDetailView: BaseView {
    
    // MARK: - properties
    let backBarButton = UIBarButtonItem().then {
        $0.style = .done
        $0.image = UIImage(systemName: "chevron.left")
        $0.tintColor = .gray90
    }
    
    let editButton = UIButton().then {
        $0.setImage(UIImage(systemName: "pencil.line"),
                    for: .normal)
        $0.tintColor = .gray90
        $0.showsMenuAsPrimaryAction = true
    }
    
    lazy var editBarButton = UIBarButtonItem(customView: editButton)
    
    private let travelInfoStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
    }
    
    private let periodLabel = UILabel().then {
        $0.configureLabel(color: .gray100, font: .oaGothic(size: 10, weight: .medium))
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private let separatorLabel = UILabel().then {
        $0.configureLabel(color: .gray100, font: .oaGothic(size: 10, weight: .medium), text: "|")
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private let locationImageView = UIImageView().then {
        $0.image = .planDetailsLocation
        $0.tintColor = .gray100
        $0.contentMode = .scaleAspectFit
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private let areaLabel = UILabel().then {
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
        $0.backgroundColor = .white
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        [travelInfoStackView,
         travelTitleLabel,
         borderLine,
         tableView].forEach { self.addSubview($0) }
        
        [periodLabel,
         separatorLabel,
         locationImageView,
         areaLabel].forEach { travelInfoStackView.addArrangedSubview($0) }
    }
    
    override func configureConstraints() {
        let horizontalInset = CGFloat(24)
        
        travelInfoStackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(horizontalInset)
        }
        
        locationImageView.snp.makeConstraints {
            $0.size.equalTo(12)
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
        areaLabel.text = travel.area
        periodLabel.text = String(startDate: travel.startDate, endDate: travel.endDate)
        travelTitleLabel.text = travel.title
    }
}
