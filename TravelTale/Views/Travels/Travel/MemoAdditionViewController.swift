//
//  MemoAdditionViewController.swift
//  TravelTale
//
//  Created by Kinam on 6/5/24.
//

import UIKit

class MemoAdditionViewController: BaseViewController {

    // MARK: - properties
    let memoAdditionView = MemoAdditionView()
    
    // MARK: - life cycles
    override func loadView() {
        super.loadView()
        view = memoAdditionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureStyle()
        configureDelegate()
        configureAddTarget()
        bind()
        configureNavigationBar()
    }
    
    // MARK: - methods
    override func configureStyle() { }
    
    override func configureDelegate() { }
    
    override func configureAddTarget() { }
    
    override func bind() { }
    
    private func configureNavigationBar() {
        navigationItem.title = "메모 추가"
        
        let exitButton = UIBarButtonItem(image: UIImage(systemName: "x.square.fill"), style: .plain, target: self, action: #selector(handleBackButton))
        navigationItem.rightBarButtonItem = exitButton
        navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 0.84, green: 0.84, blue: 0.84, alpha: 1.00)
        
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
