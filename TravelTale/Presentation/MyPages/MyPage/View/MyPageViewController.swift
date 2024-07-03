//
//  MyPageViewController.swift
//  TravelTale
//
//  Created by 김정호 on 6/3/24.
//

import MessageUI
import UIKit

final class MyPageViewController: BaseViewController {
    
    // MARK: - properties
    private let myPageView = MyPageView()
    
    private let serviceArray = ["개인정보 처리방침", "오픈소스 라이선스"]
    private let noticeArray = ["버전", "문의하기"]
    
    static let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    
    // MARK: - life cycles
    override func loadView() {
        view = myPageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        myPageView.totalButton.addTarget(self, action: #selector(tappedTotalButton), for: .touchUpInside)
        
        [myPageView.toristSpotBookMarkButton,
         myPageView.accommodationBookMarkButton,
         myPageView.entertainmentBookMarkButton,
         myPageView.restaurantBookMarkButton].forEach { $0.addTarget(self, action: #selector(tappedCategoryButton(_:)), for: .touchUpInside) }
        
        myPageView.tableView.delegate = self
        myPageView.tableView.dataSource = self
        
        myPageView.tableView.register(MyPageTableViewCell.self, forCellReuseIdentifier: MyPageTableViewCell.identifier)
    }
    
    private func configureNavigationBar() {
        navigationItem.leftBarButtonItem = myPageView.myPageBarItem
    }
    
    @objc private func tappedTotalButton() {
        let myPageCategoryVC = MyPageCategoryViewController()
        
        myPageCategoryVC.selectedIndexPath = 0
        
        self.navigationController?.pushViewController(myPageCategoryVC, animated: true)
    }
    
    @objc private func tappedCategoryButton(_ sender: MyPageBookMarkButton) {
        let myPageCategoryVC = MyPageCategoryViewController()
        let categoryArray = ["전체", "관광지", "음식점", "숙박", "놀거리"]
        
        myPageCategoryVC.selectedIndexPath = categoryArray.firstIndex(of: sender.getButtonName()) ?? 1
        
        self.navigationController?.pushViewController(myPageCategoryVC, animated: true)
    }
    
    func tappedInquiryCell() {
        if MFMailComposeViewController.canSendMail() {
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
            
            let bodyString = """
                                이곳에 내용을 작성해 주세요.
                                
                                
                                ================================
                                Device OS : \(UIDevice.current.systemVersion)
                                ================================
                                """
            
            composeVC.setToRecipients(["gh7052@gmail.com"])
            composeVC.setSubject("문의 사항")
            composeVC.setMessageBody(bodyString, isHTML: false)
            
            self.present(composeVC, animated: true)
        } else {
            let alertController = UIAlertController(title: "메일 계정 활성화 필요",
                                                    message: "Mail 앱에서 사용자의 Email을 계정을 설정해 주세요.",
                                                    preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "확인", style: .default) { _ in
                guard let mailSettingsURL = URL(string: UIApplication.openSettingsURLString + "&&path=MAIL") else { return }
                
                if UIApplication.shared.canOpenURL(mailSettingsURL) {
                    UIApplication.shared.open(mailSettingsURL, options: [:], completionHandler: nil)
                }
            }
            alertController.addAction(alertAction)
            
            self.present(alertController, animated: true)
        }
    }
}

// MARK: - extensions
extension MyPageViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView().then {
            $0.backgroundColor = .white
        }
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView().then {
            $0.backgroundColor = .white
        }
        
        let headerLabel = UILabel().then {
            $0.configureLabel(font: .pretendard(size: 18, weight: .bold))
        }
        
        headerView.addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(12)
        }
        
        switch section {
        case 0:
            headerLabel.text = "서비스 약관"
        case 1:
            headerLabel.text = "공지사항"
        default:
            headerLabel.text = ""
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPageTableViewCell.identifier, for: indexPath) as? MyPageTableViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        
        switch indexPath.section {
        case 0:
            cell.bind(text: serviceArray[indexPath.row])
            return cell
        case 1:
            if indexPath.row == 0 {
                cell.bind(text: noticeArray[indexPath.row], version: MyPageViewController.version)
            } else {
                cell.bind(text: noticeArray[indexPath.row])
            }
            return cell
        default:
            fatalError("세션 오류")
        }
    }
}

extension MyPageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                let termPrivatePolicyVC = MyPageTermPrivacyPolicyViewController()
                navigationController?.pushViewController(termPrivatePolicyVC, animated: true)
            } else {
                let termOpenSourceVC = MyPageTermOpenSourceViewController()
                navigationController?.pushViewController(termOpenSourceVC, animated: true)
            }
        case 1:
            if indexPath.row != 0 {
                tappedInquiryCell()
            }
        default:
            fatalError("세션 오류")
        }
    }
}

extension MyPageViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, 
                               didFinishWith result: MFMailComposeResult,
                               error: Error?) {
        switch result {
        case .sent:
            print("메일 보내기 성공")
        case .cancelled:
            print("메일 보내기 취소")
        case .saved:
            print("메일 임시 저장")
        case .failed:
            print("메일 발송 실패")
        @unknown default: break
        }
        
        self.dismiss(animated: true)
    }
}
