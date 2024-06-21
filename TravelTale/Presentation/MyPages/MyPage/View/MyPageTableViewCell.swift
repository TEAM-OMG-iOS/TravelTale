//
//  MyPageTableViewCell.swift
//  TravelTale
//
//  Created by 배지해 on 6/18/24.
//

import UIKit

final class MyPageTableViewCell: BaseTableViewCell {
    
    // MARK: - properties
    static let identifier = String(describing: MyPageTableViewCell.self)
    
    private let label = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 15, weight: .bold), numberOfLines: 0)
    }
    
    private let versionLabel = UILabel().then {
        $0.configureLabel(color: .gray90, font: .pretendard(size: 15, weight: .bold), numberOfLines: 0)
        $0.isHidden = true
    }
    
    private let chevronImage = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")
        $0.tintColor = .gray90
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        addSubview(label)
        addSubview(versionLabel)
        addSubview(chevronImage)
    }
    
    override func configureConstraints() {
        label.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(36)
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(chevronImage.snp.leading).inset(12)
        }
        
        versionLabel.snp.makeConstraints {
            $0.trailing.equalTo(chevronImage.snp.leading).offset(-16)
            $0.centerY.equalToSuperview()
        }
        
        chevronImage.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(36)
            $0.height.equalTo(16)
            $0.width.equalTo(8)
            $0.centerY.equalToSuperview()
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        self.backgroundColor = highlighted ? .green10 : .white
    }
    
    func bind(text: String, version: String = "") {
        label.text = text
        versionLabel.text = version
        versionLabel.isHidden = (version == "")
        chevronImage.isHidden = (version != "")
    }
}
