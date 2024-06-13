//
//  BookMarkButton.swift
//  TravelTale
//
//  Created by 배지해 on 6/14/24.
//

import UIKit

class BookMarkButton: UIButton {
    
    // MARK: - properties
    private let bookMarkImageView = UIImageView()
    
    private let bookMarkLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 18, weight: .regular))
    }
    
    private let chevronImageView = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")
    }
    
    var text: String? {
        didSet { bookMarkLabel.text = text }
    }
    
    var bookMarkImage: UIImage? {
        didSet { bookMarkImageView.image = bookMarkImage }
    }
    
    // MARK: - methods
    init() {
        super.init(frame: .zero)
        configureHierarchy()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        addSubview(bookMarkImageView)
        addSubview(bookMarkLabel)
        addSubview(chevronImageView)
    }
    
    func configureConstraints() {
        bookMarkImageView.snp.makeConstraints{
            $0.top.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(35)
        }
        
        bookMarkLabel.snp.makeConstraints{
            $0.top.equalTo(bookMarkImageView.snp.bottom).offset(40)
            $0.leading.bottom.equalToSuperview().inset(16)
        }
        
        chevronImageView.snp.makeConstraints{
            $0.trailing.bottom.equalToSuperview().inset(16)
            $0.verticalEdges.equalTo(bookMarkLabel)
        }
    }
}
