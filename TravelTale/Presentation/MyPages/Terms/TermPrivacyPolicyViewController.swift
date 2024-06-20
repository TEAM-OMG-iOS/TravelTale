//
//  TermPrivacyPolicyViewController.swift
//  TravelTale
//
//  Created by 배지해 on 6/20/24.
//
import UIKit

final class TermPrivacyPolicyViewController: BaseViewController {
    
    // MARK: - properties
    private let termView = TermView()
    
    // MARK: - life cycles
    override func loadView() {
        view = termView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        termView.setText(text: getPrivacyPolicyString())
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
        navigationItem.title = "개인정보 처리방침"
        navigationItem.leftBarButtonItem = termView.backButton
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
