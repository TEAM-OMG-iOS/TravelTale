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
    private let alertMessage = """
이전으로 돌아가면 작성 내용이 저장되지 않습니다.
정말 돌아가시겠습니까?
"""
    
    private var preSelectedIndexPath: IndexPath?
    private var travels = RealmManager.shared.fetchTravels() {
        didSet {
            detailScheduleSelectView.showNotFoundView(travels.isEmpty)
            detailScheduleSelectView.tableView.reloadData()
        }
    }
    
    var placeDetail: PlaceDetail
    
    // MARK: - life cycles
    init(placeDetail: PlaceDetail) {
        self.placeDetail = placeDetail
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = detailScheduleSelectView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailScheduleSelectView.showNotFoundView(travels.isEmpty)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        detailScheduleSelectView.startLoadingAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
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
        detailScheduleSelectView.nextBtn.addTarget(self, action: #selector(tappedNextButton), for: .touchUpInside)
        detailScheduleSelectView.backButton.target = self
        detailScheduleSelectView.backButton.action = #selector(configureBackAlert)
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "내 여행에 추가"
        navigationItem.leftBarButtonItem = detailScheduleSelectView.backButton
    }
    
    private func dayDifference(from startDate: Date, to endDate: Date) -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: startDate, to: endDate)
        
        if let dayDifference = components.day {
            return dayDifference == 0 ? "1" : String(dayDifference)
        } else {
            return "1"
        }
    }
    
    @objc private func configureBackAlert() {
        let alert = UIAlertController(title: "경고", message: alertMessage, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .destructive) {_ in
            self.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        self.present(alert, animated: true)
    }
    
    @objc private func tappedNextButton() {
        guard let selectedIndexPath = detailScheduleSelectView.tableView.indexPathForSelectedRow else { return }
        let selectedData = travels[selectedIndexPath.row]
        let nextVC = DetailScheduleAddViewController(allDays: dayDifference(from: selectedData.startDate, to: selectedData.endDate), selectedTravel: selectedData, selectedPlace: placeDetail)
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
                detailScheduleSelectView.updateButtonState()
                cell.setSelected(false, animated: true)
            }
        } else {
            preSelectedIndexPath = indexPath
            detailScheduleSelectView.updateButtonState()
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
        cell.selectionStyle = .none
        cell.bind(travel: travel)
        return cell
    }
}
