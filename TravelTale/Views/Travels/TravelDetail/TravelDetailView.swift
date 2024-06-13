//
//  TravelDetailView.swift
//  TravelTale
//
//  Created by 김정호 on 6/7/24.
//

import UIKit
import MapKit

final class TravelDetailView: BaseView {
    
    // MARK: - properties
    let backButton = UIBarButtonItem().then {
        $0.style = .done
        $0.tintColor = .black
        $0.image = .planDetailsLeftArrow
    }
    
    let settingButton = UIBarButtonItem().then {
        $0.style = .done
        $0.tintColor = .black
        $0.image = .planDetailsSetting
    }
    
    private let periodLabel = UILabel().then {
        $0.configureLabel(color: .gray100, font: .oaGothic(size: 12, weight: .medium))
    }
    
    private let locationImageView = UIImageView().then {
        $0.image = .planDetailsLocation
    }
    
    private let locationLabel = UILabel().then {
        $0.configureLabel(color: .gray100, font: .oaGothic(size: 12, weight: .medium))
    }
    
    private let titleLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 20, weight: .bold))
    }
    
    private let mapView = MKMapView()
    
    // MARK: - methods
    override func configureHierarchy() {
        self.addSubview(periodLabel)
        self.addSubview(locationImageView)
        self.addSubview(locationLabel)
        self.addSubview(titleLabel)
        self.addSubview(mapView)
    }
    
    override func configureConstraints() {
        periodLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(12)
            $0.leading.equalToSuperview().offset(20)
        }
        
        locationImageView.snp.makeConstraints {
            $0.centerY.equalTo(periodLabel)
            $0.leading.equalTo(periodLabel.snp.trailing)
        }
        
        locationLabel.snp.makeConstraints {
            $0.top.equalTo(periodLabel)
            $0.leading.equalTo(locationImageView.snp.trailing).offset(4)
            $0.trailing.lessThanOrEqualToSuperview().inset(-20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(periodLabel.snp.bottom).offset(6)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        mapView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(14)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
}
