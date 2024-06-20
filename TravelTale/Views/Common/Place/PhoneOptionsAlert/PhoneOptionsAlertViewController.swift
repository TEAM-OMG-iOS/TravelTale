//
//  PhoneOptionsAlertViewController.swift
//  TravelTale
//
//  Created by 배지해 on 6/20/24.
//

import UIKit

final class PhoneOptionsAlertViewController: BaseViewController {
    
    // MARK: - properties
    private let phoneOptionsAlert = PhoneOptionsAlertView()
    
    private var phoneNumber: String = "" {
        didSet {
            phoneOptionsAlert.setPhoneNumber(phoneNumber: phoneNumber)
        }
    }
    
    // MARK: - life cycles
    override func loadView() {
        view = phoneOptionsAlert
    }
    
    // MARK: - methods
    override func configureAddTarget() {
        phoneOptionsAlert.callButton.addTarget(self,
                                               action: #selector(tappedCallButton),
                                               for: .touchUpInside)
        phoneOptionsAlert.copyPhoneNumberButton.addTarget(self,
                                                          action: #selector(tappedPhoneNumberCopyButton),
                                                          for: .touchUpInside)
        phoneOptionsAlert.cancelButton.addTarget(self, 
                                                 action: #selector(tappedCancelButton),
                                                 for: .touchUpInside)
    }
    
    @objc private func tappedCallButton() {
        if let url = URL(string: "tel://\(phoneNumber)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    @objc private func tappedCancelButton() {
        dismiss(animated: false)
    }
    
    @objc private func tappedPhoneNumberCopyButton() {
        UIPasteboard.general.string = phoneNumber
        configureToast(text: "전화번호")
    }
    
    private func configureToast(text: String) {
        let toastView = CustomPopUpView()
        
        toastView.backgroundColor = .clear
        toastView.setText(text: text)
        
        configureToastConstraints(toastView: toastView)
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            toastView.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 1.5, options: .curveEaseOut, animations: {
                toastView.alpha = 0.0
            }, completion: { _ in
                toastView.removeFromSuperview()
            })
        })
    }
    
    private func configureToastConstraints(toastView: UIView) {
        view.addSubview(toastView)
        
        toastView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(24)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
    }
    
    func setPhoneNumber(phoneNumber: String) {
        self.phoneNumber = phoneNumber
    }
}
