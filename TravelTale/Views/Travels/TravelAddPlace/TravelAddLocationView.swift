//
//  TravelAddLocationView.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/11/24.
//

import UIKit

final class TravelAddLocationView: BaseView {
    
    // MARK: - properties
    private let guideLabel = UILabel().then {
        $0.text = "대표 여행 장소를 선택해주세요"
        $0.font = UIFont(name: "Pretendard-SemiBold", size: 18)
    }
    
    let tableView = UITableView().then {
        $0.backgroundColor = .white
    }
    
    var locations: [String] = ["서울특별시", "인천광역시", "부산광역시",
                               "대전광역시", "대구광역시", "울산광역시",
                               "광주광역시", "제주특별자치도", "세종특별자치시",
                               "경기도", "강원도", "충청북도", "충청남도",
                               "경상북도", "경상남도", "전라북도", "전라남도"]
    
    // MARK: - methods
    override func configureUI() {
        super.configureUI()
    }
    
    override func configureHierarchy() {
        [guideLabel,
         tableView].forEach {
            self.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        guideLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(42)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(guideLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(0)
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}

