//
//  XButton.swift
//  TravelTale
//
//  Created by Kinam on 6/10/24.
//

import UIKit
import SnapKit

final class XButton: UIButton {
    
    // MARK: - properties
    
    // MARK: - life cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - methods
    func configureUI() {
        self.setImage(UIImage(systemName: "xmark.app.fill"), for: .normal)
        self.tintColor = UIColor(red: 0.84, green: 0.84, blue: 0.84, alpha: 1.00)
    }
    
    func configureConstraints() {
        self.snp.makeConstraints {
            $0.width.height.equalTo(30)
        }
    }
}
