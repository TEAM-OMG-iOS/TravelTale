//
//  TravelAdditionViewController.swift
//  TravelTale
//
//  Created by Kinam on 6/4/24.
//

import UIKit
import SnapKit

final class TravelSelectViewController: BaseViewController {
    // MARK: - properties
    let travelSelectView = TravelSelectView()
    
    // MARK: - life cycles
    override func loadView() {
        view = travelSelectView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAddTarget()
        configureNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        travelSelectView.startLoadingAnimation()
    }
    
    // MARK: - methods
    override func configureStyle() { }
    
    override func configureDelegate() { }
    
    override func configureAddTarget() { }
    
    override func bind() { }
    
    private func setAddTarget() {
        travelSelectView.nextBtn.addTarget(self, action: #selector(tappedNextButton), for: .touchUpInside)
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
    
    @objc private func tappedNextButton() {
        let nextVC = ScheduleCreateViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc private func handleBackButton() {
        navigationController?.popViewController(animated: true)
    }
}
