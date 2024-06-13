//
//  LocationTableViewCell.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/13/24.
//

import UIKit

final class LocationTableViewCell: BaseTableViewCell {
    
    // MARK: - properties
    static let identifier = String(describing: LocationTableViewCell.self)
    
    private let locationLabel = UILabel().then {
        $0.configureLabel(alignment: .left,
                          color: .black,
                          font: .pretendard(size: 15, weight: .bold))
    }
    
    // MARK: - life cycles
    override func prepareForReuse() {
        super.prepareForReuse()
        
        locationLabel.text = nil
        backgroundColor = .white
    }
    
    // MARK: - methods
    override func configureUI() {
        super.configureUI()
        
        configureBackgroundView()
    }
    
    override func configureHierarchy() {
        [locationLabel].forEach {
            self.contentView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        locationLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(12)
            $0.height.equalTo(48)
        }
    }
    
    private func configureBackgroundView() {
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = .clear
        self.selectedBackgroundView = selectedBackgroundView
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        backgroundColor = selected ? .green10 : .white
    }
    
    func bind(text: String) {
        locationLabel.text = text
    }
}
