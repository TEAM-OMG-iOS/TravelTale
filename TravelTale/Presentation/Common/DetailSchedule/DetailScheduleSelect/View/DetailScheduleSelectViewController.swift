//
//  DetailScheduleSelectViewController.swift
//  TravelTale
//
//  Created by Kinam on 6/4/24.
//

import UIKit

final class DetailScheduleSelectViewController: BaseViewController {
    
    // MARK: - properties
    private let detailScheduleSelectView = DetailScheduleSelectView()
    private var preSelectedIndexPath: IndexPath?
    private let travels = RealmManager.shared.fetchTravels()
    
    var placeDetail: PlaceDetail?
    
    // MARK: - life cycles
    override func loadView() {
        view = detailScheduleSelectView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        detailScheduleSelectView.startLoadingAnimation()
    }
    
    // MARK: - methods
    override func configureStyle() {
        configureNavigationBar()
    }
    
    override func configureDelegate() {
        detailScheduleSelectView.tableView.delegate = self
        detailScheduleSelectView.tableView.dataSource = self
        
        detailScheduleSelectView.tableView.register(TravelTableViewCell.self, forCellReuseIdentifier: TravelTableViewCell.identifier)
    }
    
    override func configureAddTarget() {
        detailScheduleSelectView.nextBtn.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
        detailScheduleSelectView.backButton.target = self
        detailScheduleSelectView.backButton.action = #selector(configureBackAlert)
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "내 여행에 추가"
        navigationItem.leftBarButtonItem = detailScheduleSelectView.backButton
    }
    
    @objc private func configureBackAlert() {
        let alert = UIAlertController(title: "경고", message: "작성중인 내용이 저장되지 않습니다. 계속 진행하시겠습니까?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .default) {_ in
            self.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        self.present(alert, animated: true)
    }
    
    @objc private func tappedButton() {
        guard let selectedIndexPath = detailScheduleSelectView.tableView.indexPathForSelectedRow else { return }
        let selectedData = travels[selectedIndexPath.row]
        let nextVC = DetailScheduleAddViewController()
        nextVC.selectedTravel = selectedData
        nextVC.selectedPlace = placeDetail
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension DetailScheduleSelectViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TravelTableViewCell.identifier) as? TravelTableViewCell else { return }
        
        if let selectedIndexPath =
            preSelectedIndexPath {
            if selectedIndexPath == indexPath {
                detailScheduleSelectView.tableView.deselectRow(at: indexPath, animated: true)
                preSelectedIndexPath = nil
                cell.setSelected(false, animated: true)
            }
        } else {
            preSelectedIndexPath = indexPath
            cell.setSelected(true, animated: true)
        }
    }
}

extension DetailScheduleSelectViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TravelTableViewCell.identifier, for: indexPath) as? TravelTableViewCell else { return UITableViewCell() }
        
        let travel = travels[indexPath.row]
//        cell.bind(travel: travel)
        return cell
    }
}
