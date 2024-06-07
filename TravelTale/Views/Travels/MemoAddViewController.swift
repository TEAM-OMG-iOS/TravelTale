//
//  MemoAdditionViewController.swift
//  TravelTale
//
//  Created by Kinam on 6/5/24.
//

import UIKit

class MemoAddViewController: BaseViewController {
    
    // MARK: - properties
    let memoAddView = MemoAddView().then {
        $0.memoTV.text = "메세지를 입력하세요"
        $0.memoTV.textColor = .lightGray
    }
    
    // MARK: - life cycles
    override func loadView() {
        super.loadView()
        view = memoAddView
        memoAddView.memoTV.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
// MARK: - extensions
extension MemoAddViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "메세지를 입력하세요"
            textView.textColor = UIColor.lightGray
        }
    }
}
