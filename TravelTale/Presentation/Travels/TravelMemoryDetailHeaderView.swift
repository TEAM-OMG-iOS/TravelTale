//
//  TravelMemoryDetailHeaderTableViewCell.swift
//  TravelTale
//
//  Created by 유림 on 6/14/24.
//

import Then
import UIKit

final class TravelMemoryDetailHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - properties
    static let identifier = String(String(describing: TravelMemoryDetailHeaderView.self))
    
    private let memoryLabel = UILabel().then {
        $0.configureLabel(color: .black, font: .pretendard(size: 14, weight: .medium), numberOfLines: 0)
    }
    
    // MARK: - methods
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureUI()
        configureHierarchy()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.backgroundColor = .white
    }
    
    private func configureHierarchy() {
        contentView.addSubview(memoryLabel)
    }
    
    private func configureConstraints() {
        memoryLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(12)
        }
    }
    
    func bind(memory: String) {
        memoryLabel.text = memory
    }
}
