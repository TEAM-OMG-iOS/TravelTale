//
//  PlanEditDateViewController.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/12/24.
//

import UIKit
import HorizonCalendar

final class PlanEditDateViewController: BaseViewController {
    
    // MARK: - properties
    let planEditDateView = PlanEditDateView(monthsLayout: .vertical)
    private let planEditView = PlanEditView()
    
    // MARK: - lifecycle
    override func loadView() {
        view = planEditDateView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - methods
    override func configureAddTarget() {
        planEditDateView.okButton.addTarget(self, action: #selector(tappedOkButton), for: .touchUpInside)
    }
    
    private func presentAlert() {
        let alert = UIAlertController(title: "경고", message: """
    수정된 일정만큼 일부 삭제될 수 있습니다.
    그대로 진행하시겠습니까?
    """, preferredStyle: UIAlertController.Style.alert)
        
        let cancel = UIAlertAction(title: "취소", style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            //TODO: 기존 날짜로 초기화되는 기능 추가
            self.dismiss(animated: true)
        }
        
        let ok = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func tappedOkButton() {
        presentAlert()
    }
}
