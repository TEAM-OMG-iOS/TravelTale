//
//  PlanDetailAnnotationView.swift
//  TravelTale
//
//  Created by 김정호 on 7/1/24.
//

import UIKit
import MapKit

final class PlanDetailAnnotationView: MKAnnotationView {
    
    // MARK: - properties
    static let identifier = String(describing: PlanDetailAnnotationView.self)
    
    private let annotationBasedView = UIView().then {
        $0.configureView(color: .black, clipsToBounds: true, cornerRadius: 12)
    }
    
    private let annotationIndexLabel = UILabel().then {
        $0.configureLabel(alignment: .center, color: .white, font: .oaGothic(size: 12, weight: .heavy))
    }
    
    override var annotation: MKAnnotation? {
        willSet {
            guard let planDetailAnnotation = newValue as? PlanDetailAnnotation else { return }
            
            configureHierarchy()
            configureConstraints()
            bind(index: planDetailAnnotation.index)
            
            layoutSubviews()
        }
    }
    
    // MARK: - life cycles
    override init(annotation: (any MKAnnotation)?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        frame = CGRect(x: 0, y: 0, width: 24, height: 24)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - methods
    func configureHierarchy() {
        self.addSubview(annotationBasedView)
        self.annotationBasedView.addSubview(annotationIndexLabel)
    }
    
    func configureConstraints() {
        annotationBasedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        annotationIndexLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func bind(index: Int) {
        annotationIndexLabel.text = String(index)
    }
}
