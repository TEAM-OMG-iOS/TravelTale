//
//  TravelMemoryDetailEditViewController.swift
//  TravelTale
//
//  Created by 유림 on 6/12/24.
//

import UIKit
import PhotosUI

final class TravelMemoryDetailEditViewController: BaseViewController {
    
    // MARK: - properties
    private let travelMemoryDetailEditView = TravelMemoryDetailEditView()
    
    private var travel: Travel
    
    private var selectedPhotos: [Data] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                travelMemoryDetailEditView.collectionView.reloadData()
                travelMemoryDetailEditView.updatePhotoCount(count: selectedPhotos.count)
            }
        }
    }
    
    // MARK: - life cycles
    override func loadView() {
        view = travelMemoryDetailEditView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSelectedPhotos()
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
    }
    
    override func configureDelegate() {
        travelMemoryDetailEditView.collectionView.dataSource = self
        travelMemoryDetailEditView.collectionView
            .register(TravelMemoryEditPhotoCollectionViewCell.self,
                      forCellWithReuseIdentifier: TravelMemoryEditPhotoCollectionViewCell.identifier)
        
        travelMemoryDetailEditView.memoryTextView.delegate = self
    }
    
    override func configureAddTarget() {
        travelMemoryDetailEditView.backButton.target = self
        travelMemoryDetailEditView.backButton.action = #selector(tappedBackButton)
        
        travelMemoryDetailEditView.photoButton.addTarget(self, action: #selector(tappedPhotoButton), for: .touchUpInside)
        
        travelMemoryDetailEditView.confirmButton.addTarget(self, action: #selector(tappedConfirmButton), for: .touchUpInside)
    }
    
    override func bind() { 
        travelMemoryDetailEditView.bind(travel: travel)
    }
    
    private func configureNavigationBarItems() {
        navigationItem.title = "추억 남기기"
        navigationItem.leftBarButtonItem = travelMemoryDetailEditView.backButton
      }
    
    private func setSelectedPhotos() {
        selectedPhotos = travel.photos.map { $0 }
    }
    
    // MARK: - objc functions
    @objc func tappedBackButton() {
        let alert = UIAlertController(
            title: "경고",
            message: """
    이전으로 돌아가면 작성 내용이 저장되지 않습니다.
    정말 돌아가시겠습니까?
    """,
            preferredStyle: UIAlertController.Style.alert)
        
        let cancel = UIAlertAction(title: "취소", style: .destructive)
        
        let ok = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func tappedPhotoButton() {
        var config = PHPickerConfiguration()
        config.selectionLimit = 10
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc func tappedConfirmButton() {
        self.navigationController?.popToRootViewController(animated: true)
        let memory = travelMemoryDetailEditView.memoryTextView.text
        RealmManager.shared.updateMemory(travel: travel,
                                         memory: memory,
                                         photos: selectedPhotos)
    }
}

// MARK: - extensions
extension TravelMemoryDetailEditViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TravelMemoryEditPhotoCollectionViewCell.identifier,
            for: indexPath)
                as? TravelMemoryEditPhotoCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        DispatchQueue.main.async {
            let imageData = self.selectedPhotos[indexPath.row]
            cell.bind(image: UIImage(data: imageData) ?? UIImage())
        }
        
        cell.showPrimaryPhotoLabel(index: indexPath.row)
        
        return cell
    }
}

extension TravelMemoryDetailEditViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        travelMemoryDetailEditView.setBeginText(textView: textView)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        travelMemoryDetailEditView.setEndText(textView: textView)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        travelMemoryDetailEditView.checkTextViewContent()
    }
}

extension TravelMemoryDetailEditViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        // TODO: 특정 사진만 삭제하는 기능
        selectedPhotos.removeAll()
        
        for result in results {
            let itemProvider = result.itemProvider
            
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                    if let image = image as? UIImage {
                        if let imageData = image.jpegData(compressionQuality: 0.8) {
                            self.selectedPhotos.append(imageData)
                        }
                    } else {
                        print("[loadObject error]: \(String(describing: error))")
                    }
                }
            }
        }
    }
}
