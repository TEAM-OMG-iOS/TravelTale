//
//  TravelMemoryDetailViewController.swift
//  TravelTale
//
//  Created by 유림 on 6/14/24.
//

import UIKit

final class MemoryDetailViewController: BaseViewController {
    
    // MARK: - properties
    private let travelMemoryDetailView = MemoryDetailView()
    private let travelMemoryDetailHeaderView = MemoryDetailTableHeaderView()
    
    private var travel: Travel
    
    private var memoryImages: [UIImage] = [] {
        didSet {
            travelMemoryDetailView.tableView.reloadData()
        }
    }
    
    // MARK: - life cycles
    override func loadView() {
        view = travelMemoryDetailView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - methods
    init(travel: Travel) {
        self.travel = travel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureStyle() {
        configureNavigationBarItems()
        travelMemoryDetailView.tableView.separatorStyle = .none
    }
    
    override func configureDelegate() {
        travelMemoryDetailView.tableView.dataSource = self
        travelMemoryDetailView.tableView.delegate = self
        
        travelMemoryDetailView.tableView
            .register(MemoryDetailTableViewCell.self,
                      forCellReuseIdentifier: MemoryDetailTableViewCell.identifier)
        
        travelMemoryDetailView.tableView.register(
            MemoryDetailTableHeaderView.self,
            forHeaderFooterViewReuseIdentifier: MemoryDetailTableHeaderView.identifier)
    }
    
    override func configureAddTarget() {
        travelMemoryDetailView.backBarButton.target = self
        travelMemoryDetailView.backBarButton.action = #selector(tappedBackButton)
        configurePopupButton()
    }
    
    override func bind() {
        travelMemoryDetailView.bind(travel: travel)
        travelMemoryDetailHeaderView.bind(memory: travel.memory ?? "")
        getMemoryImages(travel: travel)
    }
    
    private func configureNavigationBarItems() {
        navigationItem.leftBarButtonItem = travelMemoryDetailView.backBarButton
        navigationItem.rightBarButtonItem = travelMemoryDetailView.editBarButton
      }
    
    private func configurePopupButton() {
        travelMemoryDetailView.editButton.menu = UIMenu(
            children: [
                UIAction(title: "편집", state: .off, handler: { _ in
                    self.tappedEditButton() }),
                UIAction(title: "삭제", attributes: .destructive,state: .off, handler: { _ in
                    print("삭제")
                })
            ]
        )
    }
    
    private func getMemoryImages(travel: Travel) {
        let imageDatas = self.travel.photos
        for imageData in imageDatas {
            if let image = UIImage(data: imageData) {
                memoryImages.append(image)
            }
        }
    }
    
    private func tappedEditButton() {
        let nextVC = MemoryAddEditViewController(travel: travel)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func tappedBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - extensions
extension MemoryDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoryImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoryDetailTableViewCell.identifier) as? MemoryDetailTableViewCell else { return UITableViewCell() }
        
        cell.bind(image: memoryImages[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
}

extension MemoryDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let image = memoryImages[indexPath.row]
        let aspectRatio = image.size.height / image.size.width
        let imageWidth = tableView.frame.width - 48
        let cellHeight = imageWidth * aspectRatio + 16
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: MemoryDetailTableHeaderView.identifier) as? MemoryDetailTableHeaderView
        else { return UIView() }
        
        headerView.bind(memory: travel.memory ?? "")
        return headerView
    }
}
