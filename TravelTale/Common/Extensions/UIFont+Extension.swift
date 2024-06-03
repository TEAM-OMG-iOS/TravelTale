//
//  UIFont+Extension.swift
//  TravelTale
//
//  Created by 김정호 on 6/3/24.
//

import UIKit

extension UIFont {
    static func pretendard(size fontSize: CGFloat, weight: UIFont.Weight) -> UIFont {
        let familyName = "Pretendard"
        var weightString: String
        
        switch weight {
        case .bold:
            weightString = "Bold"
        case .heavy:
            weightString = "ExtraBold"
        case .ultraLight:
            weightString = "ExtraLight"
        case .light:
            weightString = "Light"
        case .medium:
            weightString = "Medium"
        case .regular:
            weightString = "Regular"
        case .semibold:
            weightString = "SemiBold"
        case .thin:
            weightString = "Thin"
        default:
            weightString = "Medium"
        }
        
        guard let font = UIFont(name: "\(familyName)-\(weightString)", size: fontSize) else {
            print("프리텐다드체 폰트 변환 실패")
            return .systemFont(ofSize: fontSize, weight: weight)
        }
        
        return font
    }
    
    static func oaGothic(size fontSize: CGFloat, weight: UIFont.Weight) -> UIFont {
        let familyName = "OAGothic"
        var weightString: String
        
        switch weight {
        case .heavy:
            weightString = "ExtraBold"
        default:
            weightString = "Medium"
        }
        
        guard let font = UIFont(name: "\(familyName)-\(weightString)", size: fontSize) else {
            print("오아고딕체 폰트 변환 실패")
            return .systemFont(ofSize: fontSize, weight: weight)
        }
        
        return font
    }
}
