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
    private var travelData: Travel? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                travelMemoryDetailEditView.collectionView.reloadData()
//                travelMemoryDetailEditView.updatePhotoCount(count: travelData.memoryImageDatas.count)
            }
        }
    }
    
    // MARK: - life cycles
    override func loadView() {
        view = travelMemoryDetailEditView
    }
    
    // MARK: - methods
    init(travelData: Travel?) {
        self.travelData = travelData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureStyle() {
        configureNavigationBarItems()
    }
    
    override func configureDelegate() {
//        travelMemoryDetailEditView.collectionView.dataSource = self
        travelMemoryDetailEditView.collectionView
            .register(TravelMemoryEditPhotoCollectionViewCell.self,
                      forCellWithReuseIdentifier: TravelMemoryEditPhotoCollectionViewCell.identifier)
        
        travelMemoryDetailEditView.recordTextView.delegate = self
    }
    
    override func configureAddTarget() {
        travelMemoryDetailEditView.backButton.target = self
        travelMemoryDetailEditView.backButton.action = #selector(tappedBackButton)
        
        travelMemoryDetailEditView.photoButton.addTarget(self, action: #selector(tappedPhotoButton), for: .touchUpInside)
        
        travelMemoryDetailEditView.confirmButton.addTarget(self, action: #selector(tappedConfirmButton), for: .touchUpInside)
    }
    
    override func bind() { 
//        travelMemoryDetailEditView.bind(travel: travelData)
    }
    
    private func configureNavigationBarItems() {
        navigationItem.title = "추억 남기기"
        navigationItem.leftBarButtonItem = travelMemoryDetailEditView.backButton
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
        // TODO: realm - travel 데이터 업데이트 로직 추가
        self.navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - extensions
//extension TravelMemoryDetailEditViewController: UICollectionViewDataSource {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return travelData.memoryImageDatas.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(
//            withReuseIdentifier: TravelMemoryEditPhotoCollectionViewCell.identifier,
//            for: indexPath)
//                as? TravelMemoryEditPhotoCollectionViewCell
//        else {
//            return UICollectionViewCell()
//        }
//        
//        if let imageData = self.travelData.memoryImageDatas[indexPath.row] {
//            DispatchQueue.main.async {
//                cell.bind(image: UIImage(data: imageData) ?? UIImage())
//            }
//        }
//        
//        if indexPath.row == 0 {
//            cell.showPrimaryPhotoLabel()
//        }
//        
//        return cell
//    }
//}

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
        
        // TODO: memory 생성 상황에서는 removeAll o, 수정 상황에서는 x
//        travelData.memoryImageDatas.removeAll()
        
        for result in results {
            let itemProvider = result.itemProvider
            
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                    if let image = image as? UIImage {
                        if image.jpegData(compressionQuality: 1.0) != nil {
//                            self.travelData.memoryImageDatas.append(imageData)
                        }
                    } else {
                        print("[loadObject error]: \(String(describing: error))")
                    }
                }
            }
        }
    }
}
