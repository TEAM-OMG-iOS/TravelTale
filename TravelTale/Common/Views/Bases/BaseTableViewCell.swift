//
//  BaseTableViewCell.swift
//  TravelTale
//
//  Created by 김정호 on 6/3/24.
//

import UIKit
import SnapKit
import Then

class BaseTableViewCell: UITableViewCell, BaseViewProtocol {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        configureHierarchy()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configureUI() {
        self.backgroundColor = .white
    }
    
    func configureHierarchy() { }
    
    func configureConstraints() { }
}
