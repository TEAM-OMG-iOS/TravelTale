//
//  TravelRenewCalendarViewController.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/12/24.
//

import UIKit
import HorizonCalendar

final class TravelRenewCalendarViewController: BaseViewController {
    
    // MARK: - properties
    let travelRenewCalendarView = TravelRenewCalendarView(monthsLayout: .vertical)
    
    // MARK: - lifecycle
    override func loadView() {
        view = travelRenewCalendarView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        travelRenewCalendarView.okButton.isEnabled = false
        travelRenewCalendarView.okButton.setTitle("2박 3일", for: .normal)
    }
    
    // MARK: - methods
    override func configureAddTarget() {
        travelRenewCalendarView.okButton.addTarget(self, action: #selector(tappedSetAlert), for: .touchUpInside)
    }

    private func setAlert() {
        let alert = UIAlertController(title: "경고", message: """
    수정된 일정만큼 일부 삭제될 수 있습니다.
    그대로 진행하시겠습니까?
    """, preferredStyle: UIAlertController.Style.alert)
        
        let cancel = UIAlertAction(title: "취소", style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            //TODO: 기존 날짜로 초기화되는 기능 추가
            self.dismiss(animated: true, completion: nil)
        }
        
        let ok = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func tappedSetAlert() {
        setAlert()
    }
}
