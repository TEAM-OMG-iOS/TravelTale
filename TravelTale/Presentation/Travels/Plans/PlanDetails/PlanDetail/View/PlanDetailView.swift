//
//  PlanDetailView.swift
//  TravelTale
//
//  Created by 김정호 on 6/7/24.
//

import UIKit
import MapKit

final class PlanDetailView: BaseView {
    
    // MARK: - properties
    let backButton = UIBarButtonItem().then {
        $0.style = .done
        $0.tintColor = .black
        $0.image = .planDetailsLeftArrow
    }
    
    let settingButton = UIBarButtonItem().then {
        $0.style = .done
        $0.tintColor = .black
        $0.image = .planDetailsSetting
    }
    
    private let periodLabel = UILabel().then {
        $0.configureLabel(color: .gray100, font: .oaGothic(size: 12, weight: .medium))
    }
    
    private let locationImageView = UIImageView().then {
        $0.image = .planDetailsLocation
    }
    
    private let locationLabel = UILabel().then {
        $0.configureLabel(color: .gray100, font: .oaGothic(size: 12, weight: .medium))
    }
    
    private let titleLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 20, weight: .bold))
    }
    
    let mapView = MKMapView()
    
    // MARK: - methods
    override func configureHierarchy() {
        self.addSubview(periodLabel)
        self.addSubview(locationImageView)
        self.addSubview(locationLabel)
        self.addSubview(titleLabel)
        self.addSubview(mapView)
    }
    
    override func configureConstraints() {
        periodLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(12)
            $0.leading.equalToSuperview().offset(24)
        }
        
        locationImageView.snp.makeConstraints {
            $0.centerY.equalTo(periodLabel)
            $0.leading.equalTo(periodLabel.snp.trailing)
        }
        
        locationLabel.snp.makeConstraints {
            $0.top.equalTo(periodLabel)
            $0.leading.equalTo(locationImageView.snp.trailing).offset(4)
            $0.trailing.lessThanOrEqualToSuperview().offset(-24)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(periodLabel.snp.bottom).offset(4)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        
        mapView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    func bind(travel: Travel, tappedDay: Int) {
        mapView.removeOverlays(mapView.overlays)
        mapView.removeAnnotations(mapView.annotations)
        
        let tappedDaySchedules = travel.schedules.filter { $0.day == "\(tappedDay)" }.sorted { lhs, rhs in
            let lshDate = lhs.date ?? Date()
            let rhsDate = rhs.date ?? Date()
            
            return lshDate < rhsDate
        }
        
        periodLabel.text = String(startDate: travel.startDate, endDate: travel.endDate) + " | "
        locationLabel.text = travel.area
        titleLabel.text = travel.title
        
        if !tappedDaySchedules.isEmpty {
            var annotations: [PlanDetailAnnotation] = []
            
            for (index, schedule) in tappedDaySchedules.enumerated() {
                if let x = schedule.mapX, let y = schedule.mapY {
                    if let longitude = Double(x), let latitude = Double(y) {
                        let annotation = PlanDetailAnnotation(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), index: index + 1)
                        annotations.append(annotation)
                    }
                }
            }
            
            if !annotations.isEmpty && annotations.count >= 2 {
                for i in 0..<annotations.count-1 {
                    let coordinates = [annotations[i].coordinate, annotations[i+1].coordinate]
                    let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
                    
                    mapView.addOverlay(polyline)
                }
            }
            
            let maxLongitude = annotations.map { $0.coordinate.longitude }.max()
            let minLongitude = annotations.map { $0.coordinate.longitude }.min()
            let maxLatitude = annotations.map { $0.coordinate.latitude }.max()
            let minLatitude = annotations.map { $0.coordinate.latitude }.min()
            
            guard let maxLongitude, let minLongitude, let maxLatitude, let minLatitude else { return }
            
            let centerLongitude = (maxLongitude.magnitude + minLongitude.magnitude) / 2.0
            let centerLatitude = (maxLatitude.magnitude + minLatitude.magnitude) / 2.0
            let centerCoordinate = CLLocationCoordinate2D(latitude: centerLatitude, longitude: centerLongitude)
            
            var longDistance: CLLocationDistance = 0.0
            
            annotations.forEach { annotation in
                let annotationCoordinate = annotation.coordinate
                
                let annotationLocation = CLLocation(latitude: annotationCoordinate.latitude, longitude: annotationCoordinate.longitude)
                let centerLocation = CLLocation(latitude: centerLatitude, longitude: centerLongitude)
                
                let distanceInMeters = centerLocation.distance(from: annotationLocation)
                
                if distanceInMeters > longDistance {
                    longDistance = distanceInMeters
                }
            }
            
            let region = MKCoordinateRegion(center: centerCoordinate,
                                            latitudinalMeters: longDistance * 2.0,
                                            longitudinalMeters: longDistance * 2.0)
            
            mapView.addAnnotations(annotations)
            mapView.setRegion(region, animated: true)
        }
    }
}
