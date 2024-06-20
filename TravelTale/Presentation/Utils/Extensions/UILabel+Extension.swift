//
//  UILabel+Extension.swift
//  TravelTale
//
//  Created by 김정호 on 6/3/24.
//

import UIKit

extension UILabel {
    func configureLabel(alignment: NSTextAlignment = .left, color: UIColor = .black, font: UIFont, text: String? = nil, numberOfLines: Int = 1) {
        self.textAlignment = alignment
        self.textColor = color
        self.font = font
        self.text = text
        self.numberOfLines = numberOfLines
    }
}
