//
//  UIButton+Extension.swift
//  TravelTale
//
//  Created by 김정호 on 6/3/24.
//

import UIKit

extension UIButton {
    func configureButton(fontColor: UIColor = .black, font: UIFont, text: String = "") {
        let attributes: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: fontColor]
        let attributedTitle = NSAttributedString(string: text, attributes: attributes)
        self.setAttributedTitle(attributedTitle, for: .normal)
    }
}
