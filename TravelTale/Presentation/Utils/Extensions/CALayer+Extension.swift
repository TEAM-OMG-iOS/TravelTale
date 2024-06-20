//
//  CALayer+Extension.swift
//  TravelTale
//
//  Created by 유림 on 6/18/24.
//

import UIKit

extension CALayer {
    func applyShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat,
        y: CGFloat,
        blur: CGFloat
    ) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
    }
}
