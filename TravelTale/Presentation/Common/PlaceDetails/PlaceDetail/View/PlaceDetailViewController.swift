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
    
    private var placeImage: [String] = []
    
    var placeDetailData: [PlaceDetail]? {
        didSet {
            guard let placeDetail = placeDetailData?[0] else { return }
            
            if let image = placeDetail.firstImage {
                placeImage.append(image)
            }
            
            if let image2 = placeDetail.firstImage2 {
                placeImage.append(image2)
            }
            
            placeDetailView.imageCollectionView.reloadData()
            print("didSet: \(placeImage)")
            
            if let url = extractURL(from: placeDetailData?[0].homepage) {
                placeDetailView.bind(placeDetail: placeDetail, url: url, isBookMarked: isBookMarked)
            } else {
                placeDetailView.bind(placeDetail: placeDetail, url: nil, isBookMarked: isBookMarked)
            }
        }
    }
    
    // MARK: - life cycles
    override func loadView() {
        view = placeDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        placeDetailView.imageCollectionView.register(PlaceDetailCollectionViewCell.self, 
                                                     forCellWithReuseIdentifier: PlaceDetailCollectionViewCell.identifier)
        
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
        let PlaceDetailAlertVC = PlaceDetailAlertViewController()
        
        // TODO: - 전화번호 정보 바인딩
        if let phoneNumber = placeDetailData?[0].tel {
            PlaceDetailAlertVC.setPhoneNumber(phoneNumber: phoneNumber)
        }
        
        PlaceDetailAlertVC.modalPresentationStyle = .overFullScreen
        present(PlaceDetailAlertVC, animated: false)
    }
    
    @objc private func tappedWebsiteButton() {
        // TODO: - 홈페이지 정보 바인딩
        if let homepage = extractURL(from: placeDetailData?[0].homepage), let url = URL(string: homepage){
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
        let placeDetailToastView = PlaceDetailToastView()
        
        placeDetailToastView.setText(text: text)
        configureToastConstraints(toastView: placeDetailToastView)
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            placeDetailToastView.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 1.5, options: .curveEaseOut, animations: {
                placeDetailToastView.alpha = 0.0
            }, completion: { _ in
                placeDetailToastView.removeFromSuperview()
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
    
    private func extractURL(from htmlString: String?) -> String? {
        guard let htmlString = htmlString else { return nil }
        
        do {
            let regex = try NSRegularExpression(pattern: "<a href=\"([^\"]*)\"", options: [])
            let nsString = htmlString as NSString
            let results = regex.matches(in: htmlString, options: [], range: NSMakeRange(0, nsString.length))
            if let match = results.first {
                let url = nsString.substring(with: match.range(at: 1))
                return url
            }
        } catch let error {
            print("Error : \(error.localizedDescription)")
        }
        
        return nil
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
        print("numberOfItems: \(placeImage)")
        
        return placeImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceDetailCollectionViewCell.identifier,
                                                      for: indexPath) as! PlaceDetailCollectionViewCell
        // TODO: - 장소 사진 바인딩
        
        print("cell: \(placeImage)")
        
        cell.bind(image: placeImage[indexPath.row])
        
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
