//
//  TravelSectionHeaderView.swift
//  TravelTale
//
//  Created by 유림 on 6/8/24.
//

import Then
import UIKit

final class TravelSectionHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - properties
    static let identifier = String(String(describing: TravelSectionHeaderView.self))
    
    private let titleLabel = UILabel().then {
        $0.configureLabel(color: .black, font: .pretendard(size: 18, weight: .bold))
    }
    
    
    // MARK: - methods
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        contentView.addSubview(titleLabel)
    }
    
    private func configureConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
    }
    
    func bind(title: String) {
        titleLabel.text = title
    }
}
