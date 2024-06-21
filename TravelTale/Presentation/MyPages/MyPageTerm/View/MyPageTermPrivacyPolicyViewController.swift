//
//  MyPageTermPrivacyPolicyViewController.swift
//  TravelTale
//
//  Created by 배지해 on 6/20/24.
//
import UIKit

final class MyPageTermPrivacyPolicyViewController: BaseViewController {
    
    // MARK: - properties
    private let myPageTermView = MyPageTermView()
    
    // MARK: - life cycles
    override func loadView() {
        view = myPageTermView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myPageTermView.setText(text: getPrivacyPolicyString())
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
        myPageTermView.backButton.target = self
        myPageTermView.backButton.action = #selector(tappedBackButton)
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "개인정보 처리방침"
        navigationItem.leftBarButtonItem = myPageTermView.backButton
    }
    
    @objc private func tappedBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    private func getPrivacyPolicyString() -> String {
        guard let rtfPath = Bundle.main.url(forResource: "TermPrivacyPolicy", withExtension: "rtf"),
              let rtfData = try? Data(contentsOf: rtfPath),
              let rtfText = try? NSAttributedString(data: rtfData, options: [:], documentAttributes: nil)
        else {
            print("TestRichText 파일을 찾을 수 없습니다.")
            return ""
        }
        
        return rtfText.string
    }
}
