//
//  CategoryView.swift
//  TravelTale
//
//  Created by 배지해 on 6/15/24.
//

import UIKit
import XLPagerTabStrip

final class CategoryView: BaseView {
    
    // MARK: - properties
    private let layout = UICollectionViewFlowLayout()
    
    lazy var buttonBarView = ButtonBarView(frame: .zero, collectionViewLayout: layout).then {
        $0.backgroundColor = .white
        $0.selectedBar.backgroundColor = .black
    }
    
    private let topBorder = UIView().then {
        $0.backgroundColor = .gray70
    }
    
    private let bottomBorder = UIView().then {
        $0.backgroundColor = .gray70
    }
    
    private let containerVew = UIView().then {
        $0.configureView(color: .white)
    }
    
    // MARK: - methods
    override func configureUI() {
        super.configureUI()
    }
    
    override func configureHierarchy() {
        addSubview(buttonBarView)
        addSubview(topBorder)
        addSubview(bottomBorder)
        addSubview(containerVew)
    }
    
    override func configureConstraints() {
        buttonBarView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(40)
        }
        
        topBorder.snp.makeConstraints {
            $0.horizontalEdges.top.equalTo(buttonBarView)
            $0.height.equalTo(1)
        }
        
        bottomBorder.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalTo(buttonBarView)
            $0.height.equalTo(1)
        }
        
        containerVew.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(topBorder.snp.bottom)
            $0.bottom.equalTo(bottomBorder.snp.top)
        }
    }
}
