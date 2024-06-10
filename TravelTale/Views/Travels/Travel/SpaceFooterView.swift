//
//  SpaceFooterView.swift
//  TravelTale
//
//  Created by 유림 on 6/8/24.
//

import UIKit

final class SpaceFooterView: UITableViewHeaderFooterView {
    
    // MARK: - methods
    static let identifier = String(describing: SpaceFooterView.self)
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
