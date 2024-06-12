//
//  TravelLocationTableViewCell.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/5/24.
//

import UIKit

final class TravelLocationTableViewCell: BaseTableViewCell {
    
    // MARK: - properties
    static let identifier = "LocationTableViewCell"
    
    private let locationLabel = UILabel().then {
        $0.configureLabel(alignment: .left,
                          color: .blueBlack100,
                          font: .pretendard(size: 15, weight: .bold))
    }
    
    private let checkmarkImage = UIImageView(image: UIImage(systemName: "checkmark")).then {
        $0.tintColor = .black
        $0.isHidden = true
    }
    
    // MARK: - life cycles
    override func prepareForReuse() {
        super.prepareForReuse()
        
        locationLabel.text = nil
        checkmarkImage.isHidden = true
        backgroundColor = .white
    }
    
    // MARK: - methods
    override func configureUI() {
        super.configureUI()
        
        configureBackgroundView()
    }
    
    override func configureHierarchy() {
        [locationLabel,
         checkmarkImage].forEach {
            self.contentView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        locationLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(5)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
        
        checkmarkImage.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(16)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.size.equalTo(18)
        }
    }
    
    private func configureBackgroundView() {
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = .clear
        self.selectedBackgroundView = selectedBackgroundView
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
    }
    
    func selectLocation(_ selected: Bool) {
        if selected {
            backgroundColor = .green10
            checkmarkImage.isHidden = false
        } else {
            backgroundColor = .white
            checkmarkImage.isHidden = true
        }
    }
    
    func bind(text: String) {
        locationLabel.text = text
    }
}
