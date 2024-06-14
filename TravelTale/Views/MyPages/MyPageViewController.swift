//
//  MyPageViewController.swift
//  TravelTale
//
//  Created by 김정호 on 6/3/24.
//

import UIKit

class MyPageViewController: BaseViewController {
    
    // MARK: - properties
    private let myPageView = MyPageView()
    
    // MARK: - life cycles
    override func loadView() {
        view = myPageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - methods
    override func configureStyle() {
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        
    }
}
