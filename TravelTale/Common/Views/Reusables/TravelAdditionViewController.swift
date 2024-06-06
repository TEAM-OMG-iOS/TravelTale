//
//  TravelAdditionViewController.swift
//  TravelTale
//
//  Created by Kinam on 6/4/24.
//

import UIKit
import SnapKit

final class TravelAdditionViewController: BaseViewController {
    // MARK: - properties
    let travelAdditionView1 = TravelAdditionView1()
    
    
    // MARK: - life cycles
    override func loadView() {
        super.loadView()
        view = travelAdditionView1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStyle()
        configureDelegate()
        configureAddTarget()
        bind()
        configureNavigationBar()
        travelAdditionView1.startLoadingAnimation()
    }
    
    
    
    // MARK: - methods
    override func configureStyle() { }
    
    override func configureDelegate() { }
    
    override func configureAddTarget() { }
    
    override func bind() { }
    
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
    
    
    // MARK: - extensions
}
