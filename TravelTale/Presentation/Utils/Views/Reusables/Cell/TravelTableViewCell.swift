//
//  TravelTableViewCell.swift
//  TravelTale
//
//  Created by 유림 on 6/5/24.
//

import UIKit

final class TravelTableViewCell: BaseTableViewCell {
    
    // MARK: - properties
    static let identifier = String(describing: TravelTableViewCell.self)
    
    private let containerView = UIView().then {
        $0.configureView(cornerRadius: 15)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray20.cgColor
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 12
    }
    
    private let thumbnailImageView = UIImageView().then {
        $0.configureView(color: .gray70, clipsToBounds: true, cornerRadius: 16)
        $0.contentMode = .scaleToFill
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private let detailView = UIView().then {
        $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
    
    private let borderLine = UIView().then {
        $0.configureView(color: .gray70)
    }
    
    private let periodLabel = UILabel().then {
        $0.configureLabel(color: .gray90, font: .oaGothic(size: 10, weight: .medium))
    }
    
    private let areaCapsuleView = UIView().then {
        $0.configureView(color: .blueBlack100, cornerRadius: 10)
    }
    
    private let areaNameLabel = UILabel().then {
        $0.configureLabel(color: .white, font: .pretendard(size: 12, weight: .medium))
        $0.textAlignment = .center
    }
    
    private let titleLabel = UILabel().then {
        $0.configureLabel(color: .black, font: .pretendard(size: 18, weight: .medium))
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        contentView.addSubview(containerView)
        
        containerView.addSubview(stackView)
        
        [thumbnailImageView,
         detailView].forEach { stackView.addArrangedSubview($0) }
        
        [borderLine,
         periodLabel,
         areaCapsuleView,
         titleLabel].forEach { detailView.addSubview($0) }
        
        areaCapsuleView.addSubview(areaNameLabel)
    }
    
    override func configureConstraints() {
        containerView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(6)
            $0.horizontalEdges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
        
        thumbnailImageView.snp.makeConstraints {
            $0.size.equalTo(64)
        }
        
        detailView.snp.makeConstraints {
            $0.height.equalTo(64)
        }
        
        borderLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.horizontalEdges.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        areaCapsuleView.snp.makeConstraints {
            $0.height.equalTo(22)
            $0.width.equalTo(38)
            $0.bottom.equalTo(borderLine.snp.top).offset(-8)
            $0.trailing.equalTo(borderLine)
        }
        
        areaNameLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
        
        periodLabel.snp.makeConstraints {
            $0.centerY.equalTo(areaCapsuleView)
            $0.leading.equalTo(borderLine)
        }
        
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(22)
            $0.top.equalTo(borderLine.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(borderLine)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        updateCellColor(selected)
    }
    
    private func updateCellColor(_ selected: Bool) {
        containerView.backgroundColor = selected ? .gray20 : .clear
    }
    
    func bind(travel: Travel) {
        if !travel.photos.isEmpty {
            let image = travel.photos[0]
            thumbnailImageView.image = UIImage(data: image)
        }
        titleLabel.text = travel.title
        periodLabel.text = String(startDate: travel.startDate,
                                  endDate: travel.endDate)
        areaNameLabel.text = travel.area
    }
    
    func hideThumbnail() {
        thumbnailImageView.isHidden = true
    }
}
