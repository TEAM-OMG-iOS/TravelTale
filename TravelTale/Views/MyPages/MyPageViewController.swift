//
//  MyPageViewController.swift
//  TravelTale
//
//  Created by 김정호 on 6/3/24.
//

import UIKit

final class MyPageViewController: BaseViewController {
    
    // MARK: - properties
    private let myPageView = MyPageView()

    private let serviceArray = ["개인정보 처리방침", "오픈소스 라이선스"]
    private let noticeArray = ["버전","문의하기"]
    
    static var version = "1.0.0"
    
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
        
        myPageView.tableView.register(MyPageServiceTableViewCell.self, forCellReuseIdentifier: MyPageServiceTableViewCell.identifier)
    }
    
    private func configureNavigationBar() {
        navigationItem.leftBarButtonItem = myPageView.myPageBarItem
    }
    
    @objc private func tappedTotalButton() {
        let bookMarkVC = BookMarkViewController()
        
        bookMarkVC.selectedIndexPath = 0
        
        self.navigationController?.pushViewController(bookMarkVC, animated: true)
    }
    
    @objc private func tappedCategoryButton(_ sender: BookMarkButton) {
        let bookMarkVC = BookMarkViewController()
        let categoryArray = ["전체", "관광지", "음식점", "숙박", "놀거리"]
        
        bookMarkVC.selectedIndexPath = categoryArray.firstIndex(of: sender.getButtonName()) ?? 1
        
        self.navigationController?.pushViewController(bookMarkVC, animated: true)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPageServiceTableViewCell.identifier, for: indexPath) as? MyPageServiceTableViewCell else {
            return UITableViewCell()
        }
        
        switch indexPath.section {
        case 0:
            cell.bind(text: serviceArray[indexPath.row])
            return cell
        case 1:
            if indexPath.row == 0 {
                cell.bind(text: noticeArray[indexPath.row], version: MyPageViewController.version)
            }else {
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
                let termPrivateVC = TermPrivacyPolicyViewController()
                navigationController?.pushViewController(termPrivateVC, animated: true)
            }else {
                let termOpenSourceVC = TermOpenSourceViewController()
                navigationController?.pushViewController(termOpenSourceVC, animated: true)
            }
        case 1:
            if indexPath.row == 0 {
                let termPrivateVC = TermPrivacyPolicyViewController()
                navigationController?.pushViewController(termPrivateVC, animated: true)
            }else {
                let termPrivateVC = TermPrivacyPolicyViewController()
                navigationController?.pushViewController(termPrivateVC, animated: true)
            }
        default:
            fatalError("세션 오류")
        }
    }
}
