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
    private var travelData: Travel
    var imageDatas: [Data] = [] {
        didSet {
            DispatchQueue.main.async { [self] in
                travelMemoryDetailEditView.collectionView.reloadData()
                travelMemoryDetailEditView.updatePhotoCount(count: imageDatas.count)
            }
        }
    }
    
    // MARK: - life cycles
    override func loadView() {
        view = travelMemoryDetailEditView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - methods
    init(travelData: Travel) {
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
        travelMemoryDetailEditView.collectionView.dataSource = self
        travelMemoryDetailEditView.collectionView
            .register(TravelMemoryEditPhotoCollectionViewCell.self,
                      forCellWithReuseIdentifier: TravelMemoryEditPhotoCollectionViewCell.identifier)
        
        travelMemoryDetailEditView.recordTextView.delegate = self
    }
    
    override func configureAddTarget() {
        travelMemoryDetailEditView.exitButton.target = self
        travelMemoryDetailEditView.exitButton.action = #selector(tappedExitButton)
        
        travelMemoryDetailEditView.photoButton.addTarget(self, action: #selector(tappedPhotoButton), for: .touchUpInside)
    }
    
    override func bind() { 
        travelMemoryDetailEditView.bind(travel: travelData)
    }
    
    func configureNavigationBarItems() {
        navigationItem.title = "추억 남기기"
        navigationItem.leftBarButtonItem = travelMemoryDetailEditView.exitButton
      }
    
    
    // MARK: - objc functions
    @objc func tappedExitButton() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func tappedPhotoButton() {
        print("photoButtonTapped")
        var config = PHPickerConfiguration()
        config.selectionLimit = 10
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }
}

// MARK: - extensions
extension TravelMemoryDetailEditViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TravelMemoryEditPhotoCollectionViewCell.identifier,
            for: indexPath)
                as? TravelMemoryEditPhotoCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        let imageData = self.imageDatas[indexPath.row]
        
        DispatchQueue.main.async {
            cell.bind(image: UIImage(data: imageData) ?? UIImage())
        }
        
        if indexPath.row == 0 {
            cell.showPrimaryPhotoLabel()
        }
        
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
        
        TravelMemoryPhotoManager.shared.imageDatas.removeAll()
        
        for result in results {
            let itemProvider = result.itemProvider
            
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                print("canLoadObject")
                itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                    if let image = image as? UIImage {
                        if let imageData = image.jpegData(compressionQuality: 1.0) {
                            self.imageDatas.append(imageData)
                            print("imageAppended")
                        }
                    } else {
                        print("[loadObject error]: \(String(describing: error))")
                    }
                }
            }
        }
    }
}
