//
//  TravelTableViewCell.swift
//  TravelTale
//
//  Created by 유림 on 6/5/24.
//

import UIKit

class TravelTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    let thumbnailImageView = UIImageView()
    let borderLine = UIView()
    let periodLabel = UILabel()
    let provinceCapsuleView = UIView()
    let provinceTitleLabel = UILabel()
    let detailStackView = UIStackView()
    let titleLabel = UILabel()
    
    // MARK: - Life Cycles
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
        configureHierarchy()
        configureConstraints()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Methods
    
    func configureUI() {
        self.backgroundColor = .white
        
        contentView.layer.cornerRadius = 15
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.gray20.cgColor
        
        thumbnailImageView.layer.cornerRadius = 16
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.snp.makeConstraints {
            $0.size.equalTo(64)
        }
        
        borderLine.backgroundColor = .gray20
        borderLine.snp.makeConstraints {
            $0.height.equalTo(1)
        }
        
        periodLabel.font = .oaGothic(size: 10, weight: .medium)
        periodLabel.textColor = .gray90
        
        provinceCapsuleView.backgroundColor = .blueBlack100
        provinceCapsuleView.snp.makeConstraints {
            $0.width.equalTo(38)
            $0.height.equalTo(22)
        }
        
        provinceTitleLabel.font = .pretendard(size: 12, weight: .medium)
        provinceTitleLabel.textColor = .white
        
        titleLabel.font = .pretendard(size: 18, weight: .medium)
        titleLabel.textColor = .black
        
    }
    
    func configureHierarchy() {
        
        [thumbnailImageView,
         borderLine,
         detailStackView,
         titleLabel].forEach { contentView.addSubview($0) }
        
        [periodLabel,
         provinceCapsuleView].forEach { detailStackView.addArrangedSubview($0) }
        
        provinceCapsuleView.addSubview(provinceTitleLabel)
    }
    
    func configureConstraints() {
        
        thumbnailImageView.snp.makeConstraints {
            $0.leading.verticalEdges.equalToSuperview().inset(16)
        }
        
        borderLine.snp.makeConstraints {
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        detailStackView.snp.makeConstraints {
            $0.height.equalTo(22)
            $0.bottom.equalTo(borderLine.snp.top).offset(8)
            $0.horizontalEdges.equalTo(borderLine)
        }
        
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(22)
            $0.top.equalTo(borderLine.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(borderLine)
        }
    }
    
}
