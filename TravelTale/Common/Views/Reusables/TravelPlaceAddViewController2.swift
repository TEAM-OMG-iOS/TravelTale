//
//  TravelAddViewController2.swift
//  TravelTale
//
//  Created by Kinam on 6/6/24.
//

import UIKit
import SnapKit

final class TravelPlaceAddViewController2: BaseViewController {
    // MARK: - properties
    let travelPlaceAddView2 = TravelPlaceAddView2().then {
        $0.memoTV.text = "메세지를 입력하세요"
        $0.memoTV.textColor = .lightGray
    }
    
    // MARK: - life cycles
    override func loadView() {
        super.loadView()
        view = travelPlaceAddView2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStyle()
        configureDelegate()
        configureAddTarget()
        bind()
        configureNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        travelPlaceAddView2.startLoadingAnimation()
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
}
// MARK: - extensions
extension TravelPlaceAddViewController2: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        // TextColor로 처리합니다. text로 처리하게 된다면 placeholder와 같은걸 써버리면 동작이 이상하겠죠?
        if textView.textColor == UIColor.lightGray {
            textView.text = nil // 텍스트를 날려줌
            textView.textColor = UIColor.black
        }
        
    }
    // UITextView의 placeholder
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "메세지를 입력하세요"
            textView.textColor = UIColor.lightGray
        }
    }
}
