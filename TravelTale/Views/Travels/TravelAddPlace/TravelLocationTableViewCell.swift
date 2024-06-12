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
    
    let locationLabel = UILabel().then {
        $0.configureLabel(alignment: .left,
                          color: .blueBlack100,
                          font: .pretendard(size: 15, weight: .bold))
    }
    
    private let locationButton = UIButton()
    private let checkmarkImage = UIImageView(image: UIImage(systemName: "checkmark"))
    
    // MARK: - methods
    override func configureUI() {
        super.configureUI()
        locationLabel.text = ""
        checkmarkImage.isHidden = true
        checkmarkImage.tintColor = .black
        
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = .clear
        self.selectedBackgroundView = selectedBackgroundView
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
    }
    
    override func configureHierarchy() {
        [locationLabel,
         locationButton,
         checkmarkImage].forEach {
            self.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        locationLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(5)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        locationButton.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(5)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        checkmarkImage.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(16)
            $0.trailing.equalTo(locationLabel)
        }
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
}

