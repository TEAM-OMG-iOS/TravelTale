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
    
    private let privacyPolicy = 
    """
    TravelTale 개인정보 처리방침
    
    ‘여행의 시작과 끝을 함께하는 - TravelTale’은 개인정보보호법에 따라 이용자들의 개인정보 보호 및 권익을 보호하고자 다음과 같은 처리방침을 두고 있습니다.
     당사는 개인정보처리방침을 개정하는 경우 앱 화면 및 웹사이트 공지사항을 통하여 공지할 것입니다.

    1.개인정보의 처리 목적 당사에서 개인정보를 별도로 저장하거나 이용하지 않습니다.

    2.개인정보 파일 현황 당사는 별도의 개인정보 파일을 사용하지 않으며 저장하지도 않습니다. 당사는 쿠키를 저장하지 않으며 이용하지 않습니다. 이용자가 이에 대해 의문이 있다면 해당 서비스(애플 및, 각 광고 미디어)로 직접 연락해야 합니다.

    3.개인정보의 처리 및 보유기간 당사는 개인정보를 직접적으로 저장하거나 보유하지 않습니다. 따라서 당사는 이용자의 개인정보를 처리하는 내용도 보유기간도 없습니다.

    4.개인정보의 제3자 제공에 관한 사항 당사는 개인정보를 제3자에게 제공하지 않고 있습니다.

    5.개인정보처리 위탁 당사는 개인정보를 위탁하고 있지 않습니다.

    6.정보주체의 권리, 의무 및 그 행사방법 이용자는 개인정보주체로서 권리 행사할 수 있습니다.
     1) 개인정보 열람요구 2) 오류 등이 있을 경우 정정 요구 3) 삭제요구 4) 처리 정지 요구
     당사는 개인정보를 저장하거나 위탁하지 않습니다.

    7.개인정보의 파기 당사의 어플리케이션은 독립 실행 방식의 어플리케이션으로 별도의 서버를 사용하지 않고있습니다. 또한 개인정보를 저장하지 않으므로 파기할 것이 없습니다. 그러나 사용자가 원할 경우 어플리케이션을 '삭제'함으로서 모든 데이터를 파기할 수 있습니다.

    8.타사 모듈 사용에 대한 안내 당사의 어플리케이션에 탑재된 타사 서비스 모듈은 없습니다.

    9.개인정보 보호책임자 작성 본 개인정보처리정책에 대해 궁금하신 사항이 있거나, 개인정보 처리절차에 대한 질문, 의견 또는 우려가 있을 경우 아래 연락처로 연락 주시기 바랍니다. 
    이메일 : ordinarytom72@gmail.com
    
    """
    
    // MARK: - life cycles
    override func loadView() {
        view = termView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        termView.setText(text: privacyPolicy)
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
}
