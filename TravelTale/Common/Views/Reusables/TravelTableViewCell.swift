//
//  TravelTableViewCell.swift
//  TravelTale
//
//  Created by 유림 on 6/5/24.
//

import UIKit

class TravelTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = String(describing: TravelTableViewCell.self)
    
    let containerView = UIView()
    let thumbnailImageView = UIImageView()
    let borderLine = UIView()
    let periodLabel = UILabel()
    let provinceCapsuleView = UIView()
    let provinceNameLabel = UILabel()
    let titleLabel = UILabel()
    
    // MARK: - Methods
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        configureHierarchy()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureUI() {
        
        containerView.layer.cornerRadius = 15
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.gray20.cgColor
        
        thumbnailImageView.layer.cornerRadius = 16
        thumbnailImageView.contentMode = .scaleAspectFill
        
        borderLine.backgroundColor = .gray20
        
        periodLabel.font = .oaGothic(size: 10, weight: .medium)
        periodLabel.textColor = .gray90
        
        provinceCapsuleView.backgroundColor = .blueBlack100
        provinceCapsuleView.layer.cornerRadius = 10
        
        provinceNameLabel.font = .pretendard(size: 12, weight: .medium)
        provinceNameLabel.textColor = .white
        provinceNameLabel.textAlignment = .center
        
        titleLabel.font = .pretendard(size: 18, weight: .medium)
        titleLabel.textColor = .black
        
    }
    
    private func configureHierarchy() {
        
        contentView.addSubview(containerView)
        
        [thumbnailImageView,
         borderLine,
         periodLabel,
         provinceCapsuleView,
         titleLabel].forEach { containerView.addSubview($0) }
        
        provinceCapsuleView.addSubview(provinceNameLabel)
    }
    
    private func configureConstraints() {
        
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
//            thumbnailImageView.image = UIImage(systemName: "photo")
//            thumbnailImageView.contentMode = .scaleAspectFit
        }
        
        titleLabel.text = title ?? "여행 이름을 불러올 수 없습니다."
        
        periodLabel.text = period ?? "여행 기간을 불러올 수 없습니다."
        
        provinceNameLabel.text = province ?? "미정"
        
    }
    
}
