//
//  UIImage+Extension.swift
//  TravelTale
//
//  Created by 김정호 on 6/21/24.
//

import UIKit

extension UIImage {
    func resize(width: CGFloat, height: CGFloat) -> UIImage {
        let size = CGSize(width: width, height: height)
        let render = UIGraphicsImageRenderer(size: size)
        let renderImage = render.image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
        
        return renderImage
    }
}
