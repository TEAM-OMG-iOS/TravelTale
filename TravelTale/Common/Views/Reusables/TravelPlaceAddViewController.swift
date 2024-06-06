//
//  TravelAdditionViewController.swift
//  TravelTale
//
//  Created by Kinam on 6/4/24.
//

import UIKit
import SnapKit

final class TravelAddViewController1: BaseViewController {
    // MARK: - properties
    let travelPlaceAddView1 = TravelPlaceAddView1()
    
    
    // MARK: - life cycles
    override func loadView() {
        super.loadView()
        view = travelPlaceAddView1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStyle()
        configureDelegate()
        configureAddTarget()
        bind()
        configureNavigationBar()
        travelPlaceAddView1.startLoadingAnimation()
        setAddTarget()
    }
    
    
    
    // MARK: - methods
    override func configureStyle() { }
    
    override func configureDelegate() { }
    
    override func configureAddTarget() { }
    
    override func bind() { }
    
    private func setAddTarget() {
        travelPlaceAddView1.nextBtn.addTarget(self, action: #selector(tappedNextButton), for: .touchUpInside)
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "내 여행에 추가"
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(handleBackButton))
        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.titleTextAttributes = [
                NSAttributedString.Key.font: UIFont.oaGothic(size: 18, weight: .heavy),
                NSAttributedString.Key.foregroundColor: UIColor.black
            ]
        }
    }
    
    @objc private func handleBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func tappedNextButton() {
        let nextVC = TravelAddViewController2()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
    // MARK: - extensions
}
