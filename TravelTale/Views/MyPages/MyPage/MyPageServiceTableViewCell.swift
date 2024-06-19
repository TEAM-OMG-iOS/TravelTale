//
//  MyPageServiceTableViewCell.swift
//  TravelTale
//
//  Created by 배지해 on 6/18/24.
//

import UIKit

final class MyPageServiceTableViewCell: BaseTableViewCell {
    
    // MARK: - properties
    static let identifier = String(describing: MyPageServiceTableViewCell.self)
    
    private let label = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 15, weight: .bold), numberOfLines: 0)
    }
    
    private let chevronImage = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")
        $0.tintColor = .gray90
    }
    
    // MARK: - life cycles
    override func prepareForReuse() {
        super.prepareForReuse()
        
        label.text = nil
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        addSubview(label)
        addSubview(chevronImage)
    }
    
    override func configureConstraints() {
        label.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(36)
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(chevronImage.snp.leading).inset(12)
        }
        
        chevronImage.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(36)
            $0.height.equalTo(16)
            $0.width.equalTo(8)
            $0.centerY.equalToSuperview()
        }
    }

    func bind(text: String) {
        label.text = text
    }
}
