//
//  UIView+Extension.swift
//  TravelTale
//
//  Created by 김정호 on 6/3/24.
//

import UIKit

extension UIView {
    func configureView(color: UIColor? = nil, clipsToBounds: Bool = false, cornerRadius: CGFloat = 0) {
        self.backgroundColor = color
        self.clipsToBounds = clipsToBounds
        self.layer.cornerRadius = cornerRadius
    }
}
