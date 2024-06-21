//
//  MyPageTermOpenSourceViewController.swift
//  TravelTale
//
//  Created by 배지해 on 6/20/24.
//
import UIKit

final class MyPageTermOpenSourceViewController: BaseViewController {
    
    // MARK: - properties
    private let termView = MyPageTermView()
    
    // MARK: - life cycles
    override func loadView() {
        view = termView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        termView.setText(text: getOpenSourceText())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - methods
    override func configureStyle() {
        configureNavigationBar()
    }
    
    override func configureAddTarget() {
        termView.backButton.target = self
        termView.backButton.action = #selector(tappedBackButton)
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "오픈소스 라이선스"
        navigationItem.leftBarButtonItem = termView.backButton
    }
    
    @objc private func tappedBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    private func getOpenSourceText() -> String {
        guard let rtfPath = Bundle.main.url(forResource: "OpenSourceLicense", withExtension: "rtf"),
              let rtfData = try? Data(contentsOf: rtfPath),
              let rtfText = try? NSAttributedString(data: rtfData, options: [:], documentAttributes: nil)
        else {
            print("TestRichText 파일을 찾을 수 없습니다.")
            return ""
        }
        
        return rtfText.string
    }
}
