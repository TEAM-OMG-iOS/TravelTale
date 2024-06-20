//
//  PlaceDetailViewController.swift
//  TravelTale
//
//  Created by 배지해 on 6/18/24.
//

import MapKit
import UIKit

final class PlaceDetailViewController: BaseViewController {
    
    // MARK: - properties
    private let placeDetailView = PlaceDetailView()
    
    private var isBookMarked: Bool = false
    
    // MARK: - life cycles
    override func loadView() {
        view = placeDetailView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - methods
    override func configureDelegate() {
        placeDetailView.imageCollectionView.dataSource = self
        placeDetailView.imageCollectionView.delegate = self
        
        placeDetailView.imageCollectionView.register(PlaceDetailImageCollectionViewCell.self, 
                                                     forCellWithReuseIdentifier: PlaceDetailImageCollectionViewCell().identifier)
        
        placeDetailView.mapView.delegate = self
    }
    
    override func configureAddTarget() {
        placeDetailView.backButton.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        placeDetailView.phoneNumberButton.addTarget(self, action: #selector(tappedPhoneNumberButton), for: .touchUpInside)
        placeDetailView.websiteButton.addTarget(self, action: #selector(tappedWebsiteButton), for: .touchUpInside)
        placeDetailView.copyAddressButton.addTarget(self, action: #selector(tappedCopyButton), for: .touchUpInside)
        placeDetailView.bookMarkButton.addTarget(self, action: #selector(tappedBookMarkButton), for: .touchUpInside)
        placeDetailView.addButton.addTarget(self, action: #selector(tappedAddButton), for: .touchUpInside)
    }
    
    @objc private func tappedBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func tappedPhoneNumberButton() {
        let phoneOptionsAlertVC = PhoneOptionsAlertViewController()
        
        // TODO: - 전화번호 정보 바인딩
        phoneOptionsAlertVC.setPhoneNumber(phoneNumber: "010-5145-7665")
        phoneOptionsAlertVC.modalPresentationStyle = .overFullScreen
        present(phoneOptionsAlertVC, animated: false)
    }
    
    @objc private func tappedWebsiteButton() {
        // TODO: - 홈페이지 정보 바인딩
        if let url = URL(string: "https://www.naver.com") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @objc private func tappedCopyButton() {
        if let address = placeDetailView.copyAddress() {
            UIPasteboard.general.string = address
        }
        configureToast(text: "주소")
    }
    
    @objc private func tappedBookMarkButton() {
        if isBookMarked {
            placeDetailView.configureBookMarkButton(isBookMarked: false)
            isBookMarked = false
        }else {
            placeDetailView.configureBookMarkButton(isBookMarked: true)
            isBookMarked = true
        }
    }
    
    @objc private func tappedAddButton() {
        // TODO: - 일정에 추가하기 페이지로 이동
    }
    
    private func configureToast(text: String) {
        let toastView = CustomPopUpView()
        
        toastView.bind(text: text)
        configureToastConstraints(toastView: toastView)
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            toastView.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 1.5, options: .curveEaseOut, animations: {
                toastView.alpha = 0.0
            }, completion: { _ in
                toastView.removeFromSuperview()
            })
        })
    }
    
    private func configureToastConstraints(toastView: UIView) {
        view.addSubview(toastView)
        
        toastView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(24)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
    }
}

// MARK: - extensions
extension PlaceDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}

extension PlaceDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO: - 장소 사진 바인딩
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceDetailImageCollectionViewCell().identifier,
                                                      for: indexPath) as! PlaceDetailImageCollectionViewCell
        
        // TODO: - 장소 사진 바인딩
        
        return cell
    }
}

extension PlaceDetailViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        let identifier = "CustomAnnotationView"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        let annotationImage = UIImage.annotation
        
        let size = CGSize(width: 80, height: 100)
        UIGraphicsBeginImageContext(size)
        annotationImage.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        annotationView?.image = resizedImage
        
        return annotationView
    }
}
