//
//  TravelTableViewCell.swift
//  TravelTale
//
//  Created by 유림 on 6/5/24.
//

import UIKit

class TravelTableViewCell: BaseTableViewCell {
    
    // MARK: - properties
    static let identifier = String(describing: TravelTableViewCell.self)
    
    private let containerView = UIView().then {
        $0.configureView(cornerRadius: 15)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray20.cgColor
    }
    
    private let thumbnailImageView = UIImageView().then {
        $0.configureView(cornerRadius: 16)
        $0.contentMode = .scaleAspectFill
    }
    
    private let borderLine = UIView().then {
        $0.configureView(color: .gray20)
    }
    
    private let periodLabel = UILabel().then {
        $0.configureLabel(color: .gray90, font: .oaGothic(size: 10, weight: .medium))
    }
    
    private let provinceCapsuleView = UIView().then {
        $0.configureView(color: .blueBlack100, cornerRadius: 10)
    }
    
    private let provinceNameLabel = UILabel().then {
        $0.configureLabel(color: .white, font: .pretendard(size: 12, weight: .medium))
        $0.textAlignment = .center
    }
    
    private let titleLabel = UILabel().then {
        $0.configureLabel(color: .black, font: .pretendard(size: 18, weight: .medium))
    }
    
    
    // MARK: - methods
    override func configureHierarchy() {
        contentView.addSubview(containerView)
        
        [thumbnailImageView,
         borderLine,
         periodLabel,
         provinceCapsuleView,
         titleLabel].forEach { containerView.addSubview($0) }
        
        provinceCapsuleView.addSubview(provinceNameLabel)
    }
    
    override func configureConstraints() {
        containerView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(6)
            $0.horizontalEdges.equalToSuperview()
        }
        
        thumbnailImageView.snp.makeConstraints {
            $0.size.equalTo(64)
            $0.leading.verticalEdges.equalToSuperview().inset(16)
        }
        
        borderLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        periodLabel.snp.makeConstraints {
            $0.centerY.equalTo(provinceCapsuleView)
            $0.leading.equalTo(borderLine)
        }
        
        provinceCapsuleView.snp.makeConstraints {
            $0.height.equalTo(22)
            $0.width.equalTo(38)
            $0.bottom.equalTo(borderLine.snp.top).offset(-8)
            $0.trailing.equalTo(borderLine)
        }
        
        provinceNameLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(22)
            $0.top.equalTo(borderLine.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(borderLine)
        }
    }
    
    func bind(image: Data?, title: String?, period: String?, province: String?) {
        if let image = image {
            thumbnailImageView.image = UIImage(data: image)
        } else {
            thumbnailImageView.backgroundColor = .gray20
            thumbnailImageView.tintColor = .white
        }
        
        titleLabel.text = title ?? "여행 이름을 불러올 수 없습니다."
        periodLabel.text = period ?? "여행 기간을 불러올 수 없습니다."
        provinceNameLabel.text = province ?? "미정"
    }
}
