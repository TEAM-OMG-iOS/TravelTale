//
//  DiscoveryCategoryViewController.swift
//  TravelTale
//
//  Created by 배지해 on 6/15/24.
//

import UIKit
import XLPagerTabStrip

final class DiscoveryCategoryViewController: ButtonBarPagerTabStripViewController {
    
    // MARK: - properties
    private let backButton = UIBarButtonItem().then {
        $0.style = .done
        $0.image = UIImage(systemName: "chevron.left")
        $0.tintColor = .gray90
    }
    
    private let topBorder = UIView().then {
        $0.backgroundColor = .gray70
    }
    
    private let bottomBorder = UIView().then {
        $0.backgroundColor = .gray70
    }
    
    var selectedIndexPath = 0
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureHierarchy()
        configureConstraints()
        configureAddTarget()
        configureNavigationBar()
    }
    
    // MARK: - methods
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        buttonBarView.backgroundColor = .white
        buttonBarView.selectedBar.backgroundColor = .black
        buttonBarView.isScrollEnabled = false
        
        configureButtonBar()
        
        DispatchQueue.main.async {
            self.collectionView(self.buttonBarView, didSelectItemAt: IndexPath(row: self.selectedIndexPath, section: 0))
        }
    }
    
    private func configureHierarchy() {
        self.view.addSubview(topBorder)
        self.view.addSubview(bottomBorder)
    }
    
    private func configureConstraints() {
        buttonBarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(40)
        }
        
        topBorder.snp.makeConstraints {
            $0.horizontalEdges.top.equalTo(buttonBarView)
            $0.height.equalTo(1)
        }
        
        bottomBorder.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalTo(buttonBarView)
            $0.height.equalTo(1)
        }
    }
    
    private func configureAddTarget() {
        backButton.target = self
        backButton.action = #selector(tappedBackButton)
    }
    
    private func configureNavigationBar() {
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func configureButtonBar() {
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.buttonBarItemFont = .oaGothic(size: 15, weight: .medium)
        settings.style.buttonBarItemLeftRightMargin = 20
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        
        changeCurrentIndexProgressive = { [unowned self] (oldCell: ButtonBarViewCell?,
                                                          newCell: ButtonBarViewCell?,
                                                          progressPercentage: CGFloat,
                                                          changeCurrentIndex: Bool,
                                                          animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .gray70
            newCell?.label.textColor = .black
        }
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let touristSpotVC = TouristSpotViewController()
        let restaurantVC = RestaurantViewController()
        let accommodationVC = AccommodationViewController()
        let entertainmentVC = EntertainmentViewController()
        return [touristSpotVC, restaurantVC, accommodationVC, entertainmentVC]
    }
    
    @objc private func tappedBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        super.collectionView(collectionView, didSelectItemAt: indexPath)
        
        switch indexPath.row {
        case 0 :
            navigationItem.title = "관광지"
        case 1 :
            navigationItem.title = "음식점"
        case 2 :
            navigationItem.title = "숙박"
        default:
            navigationItem.title = "놀거리"
        }
    }
}
