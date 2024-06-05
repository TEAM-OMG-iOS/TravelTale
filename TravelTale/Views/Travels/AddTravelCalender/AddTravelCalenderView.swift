//
//  AddTravelCalenderView.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/5/24.
//

import UIKit
import HorizonCalendar

class AddTravelCalenderView: BaseView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        configureHierarchy()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        self.backgroundColor = .white
    }
    
    override func configureHierarchy() { 
        
    }
    
    override func configureConstraints() { 
        
    }
}
