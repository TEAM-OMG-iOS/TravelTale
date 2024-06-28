//
//  DetailScheduleSelectView.swift
//  TravelTale
//
//  Created by Kinam on 6/4/24.
//

import UIKit

final class DetailScheduleSelectView: BaseView {
    
    // MARK: - properties
    let alertMessage = """
이전으로 돌아가면 작성 내용이 저장되지 않습니다.
정말 돌아가시겠습니까?
"""
    
    let backButton = UIBarButtonItem().then {
        $0.style = .done
        $0.image = UIImage(systemName: "chevron.left")
        $0.tintColor = .gray90
    }
    
    private let loadingBackBar = UIView().then {
        $0.configureView(color: .gray10, cornerRadius: 4)
    }
    
    private let loadingBar = UIView().then {
        $0.configureView(color: .green80, cornerRadius: 4)
    }
    
    private let tableViewLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 18, weight: .semibold), text: "여행을 선택해주세요")
    }
    
    let tableView = UITableView().then {
        $0.configureView(color: .clear, cornerRadius: 4)
        $0.separatorStyle = .none
    }
    
    let nextBtn = GreenButton().then {
        $0.configureButton(fontColor: .white, font: .pretendard(size: 18, weight: .semibold), text: "일정 생성하러 가기")
        $0.configureView(color: .green10, cornerRadius: 24)
        $0.isEnabled = false
    }
    
    let notFoundView = NotFoundView().then {
        $0.setLabel(text: """
여행이 비어있습니다.
Plan 탭에서 생성해주세요.
""")
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        [loadingBackBar, tableViewLabel, tableView, nextBtn, notFoundView].forEach {
            self.addSubview($0)
        }
        
        [loadingBar].forEach {
            self.loadingBackBar.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        loadingBackBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(18)
            $0.height.equalTo(8)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
        }
        
        loadingBar.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.verticalEdges.equalToSuperview()
            $0.height.equalToSuperview()
            $0.width.equalTo(1)
        }
        
        tableViewLabel.snp.makeConstraints {
            $0.top.equalTo(loadingBackBar.snp.bottom).offset(56)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(24)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(tableViewLabel.snp.bottom).offset(28)
            $0.horizontalEdges.equalTo(loadingBackBar)
            $0.bottom.equalTo(nextBtn.snp.top)
        }
        
        nextBtn.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(31)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        notFoundView.snp.makeConstraints {
            $0.edges.equalTo(tableView)
        }
    }
    
    func startLoadingAnimation() {
        self.loadingBar.snp.remakeConstraints {
            $0.leading.equalToSuperview()
            $0.verticalEdges.equalToSuperview()
            $0.centerY.equalToSuperview()
            let halfwidth = loadingBackBar.frame.size.width / 2
            $0.width.equalTo(halfwidth)
        }
        
        UIView.animate(withDuration: 1.0, delay: 0, animations: {
            self.layoutIfNeeded()
        })
    }
    
    func updateButtonState() {
        if tableView.indexPathForSelectedRow == nil {
            nextBtn.isEnabled = false
            nextBtn.configureView(color: .green10, cornerRadius: 24)
        } else {
            nextBtn.isEnabled = true
            nextBtn.configureView(color: .green100, cornerRadius: 24)
        }
    }
    
    func showNotFoundView(_ isNotFound: Bool) {
        if isNotFound {
            notFoundView.isHidden = false
        } else {
            notFoundView.isHidden = true
        }
    }
    
    func dayDifference(from startDate: Date, to endDate: Date) -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: startDate, to: endDate)
        
        if let dayDifference = components.day {
            return dayDifference == 0 ? "1" : String(dayDifference)
        } else {
            return "1"
        }
    }
}
