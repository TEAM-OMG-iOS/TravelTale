//
//  SearchResultViewController.swift
//  TravelTale
//
//  Created by 김정호 on 6/21/24.
//

import UIKit
import XLPagerTabStrip

final class SearchResultViewController: ButtonBarPagerTabStripViewController {
    
    // MARK: - properties
    private let backBarButtonItem = UIBarButtonItem().then {
        $0.style = .done
        $0.image = UIImage(systemName: "chevron.left")
        $0.tintColor = .gray90
    }
    
    private let titleLabel = UILabel().then {
        $0.configureLabel(alignment: .center, font: .oaGothic(size: 18, weight: .heavy), text: "검색")
    }
    
    private let searchBar = UISearchBar().then {
        $0.searchBarStyle = .minimal
        $0.setImage(.search.resize(width: 28, height: 28), for: .search, state: .normal)
        $0.placeholder = "검색어를 입력하세요."
    }
    
    private let topBorder = UIView().then {
        $0.backgroundColor = .gray70
    }
    
    private let bottomBorder = UIView().then {
        $0.backgroundColor = .gray70
    }
    
    private let totalVC = SearchResultTabTotalViewController()
    private let touristVC = SearchResultTabTouristViewController()
    private let restaurantVC = SearchResultTabRestaurantViewController()
    private let accommodationVC = SearchResultTabAccommodationViewController()
    private let entertainmentVC = SearchResultTabEntertainmentViewController()
    
    private let userDefaultsManager = UserDefaultsManager.shared
    
    var searchText: String? {
        didSet {
            searchBar.text = searchText
        }
    }
    
    var completion: (() -> ())?
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureHierarchy()
        configureConstraints()
        configureAddTarget()
        configureDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - methods
    private func configureUI() {
        view.backgroundColor = .white
        
        configureNavigation()
        configureButtonBar()
    }
    
    private func configureHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(topBorder)
        view.addSubview(bottomBorder)
    }
    
    private func configureConstraints() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(4)
            $0.height.equalTo(40)
        }
        
        buttonBarView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(12)
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
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(buttonBarView.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    private func configureAddTarget() {
        backBarButtonItem.target = self
        backBarButtonItem.action = #selector(tappedBackBarButtonItem)
    }
    
    private func configureDelegate() {
        searchBar.delegate = self
    }
    
    private func configureNavigation() {
        navigationItem.titleView = titleLabel
        navigationItem.leftBarButtonItem = backBarButtonItem
    }
    
    private func configureButtonBar() {
        buttonBarView.backgroundColor = .white
        buttonBarView.selectedBar.backgroundColor = .black
        buttonBarView.isScrollEnabled = false
        
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.buttonBarItemFont = .pretendard(size: 16, weight: .semibold)
        settings.style.buttonBarItemLeftRightMargin = 12
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?,
                                           newCell: ButtonBarViewCell?,
                                           _: CGFloat,
                                           changeCurrentIndex: Bool,
                                           animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .gray70
            newCell?.label.textColor = .black
        }
    }
    
    @objc private func tappedBackBarButtonItem() {
        completion!()
        navigationController?.popViewController(animated: true)
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [totalVC, touristVC, restaurantVC, accommodationVC, entertainmentVC]
    }
}

// MARK: - extensions
extension SearchResultViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            let _ = userDefaultsManager.createKeyword(keyword: text)
        }
    }
}
