//
//  TravelMemoryDetailTableViewCell.swift
//  TravelTale
//
//  Created by 유림 on 6/14/24.
//

import UIKit

final class TravelMemoryDetailTableViewCell: BaseTableViewCell {
    
    // MARK: - properties
    static let identifier = String(describing: TravelMemoryDetailTableViewCell.self)
    
    private let customImageView = UIImageView().then {
        $0.configureView(clipsToBounds: true, cornerRadius: 10)
        $0.contentMode = .scaleAspectFit
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        contentView.addSubview(customImageView)
    }
    
    override func configureConstraints() { 
        customImageView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.verticalEdges.equalToSuperview().inset(8)
        }
    }
    
    func bind(image: UIImage) {
        customImageView.image = image
    }
}
