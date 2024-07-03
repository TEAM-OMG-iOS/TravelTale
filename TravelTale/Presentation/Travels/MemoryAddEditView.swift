//
//  TravelMemoryDetailEditView.swift
//  TravelTale
//
//  Created by 유림 on 6/11/24.
//

import UIKit

final class MemoryAddEditView: BaseView {
    
    // MARK: - properties
    let backButton = UIBarButtonItem().then {
        $0.style = .done
        $0.image = UIImage(systemName: "chevron.left")
        $0.tintColor = .gray90
    }
    
    private let travelInfoStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
    }
    
    private let locationImageView = UIImageView().then {
        $0.image = .planDetailsLocation
        $0.tintColor = .gray100
        $0.contentMode = .scaleAspectFit
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private let areaLabel = UILabel().then {
        $0.configureLabel(color: .gray100, font: .oaGothic(size: 10, weight: .medium))
        $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
    
    private let separatorLabel = UILabel().then {
        $0.configureLabel(color: .gray100, font: .oaGothic(size: 10, weight: .medium), text: "|")
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private let periodLabel = UILabel().then {
        $0.configureLabel(color: .gray100, font: .oaGothic(size: 10, weight: .medium))
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private let travelTitleLabel = UILabel().then {
        $0.configureLabel(alignment: .left, font: .pretendard(size: 20, weight: .bold))
    }
    
    private let borderLine = UIView().then {
        $0.configureView(color: .gray10)
    }
    
    private let recordView = UIView().then {
        $0.configureView(color: .gray5, cornerRadius: 20)
    }
    
    private let recordTitleLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 18, weight: .bold), text: "기록")
    }
    
    private let placeHolder = "기록하고 싶은 내용을 작성해주세요."
    
    lazy var memoryTextView = UITextView().then {
        $0.configureView(color: .clear)
        $0.font = .pretendard(size: 16, weight: .regular)
        $0.text = placeHolder
        $0.textColor = .lightGray
        
        $0.textContainerInset = .zero
        $0.textContainer.lineFragmentPadding = 0
    }
    
    private let photoButtonView = UIView().then {
        $0.configureView(color: .white, cornerRadius: 10)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray10.cgColor
    }
    
    private let photoButtonImageView = UIImageView().then {
        $0.image = UIImage(systemName: "photo.badge.plus")
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .black
    }
    
    private let photoButtonLabelStackView = UIStackView().then {
        $0.axis = .horizontal
    }
    
    private let photoTotalLabel = UILabel().then {
        $0.configureLabel(color: .gray80, font: .pretendard(size: 16, weight: .regular), text: "/10")
    }
    
    private let photoCountLabel = UILabel().then {
        $0.configureLabel(color: .gray80, font: .pretendard(size: 16, weight: .regular), text: "0")
    }
    
    let photoButton = UIButton().then {
        $0.configureView(color: .clear)
    }
    
    private let layout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 8
        $0.itemSize = .init(width: 80, height: 80)
    }
    
    lazy var collectionView = UICollectionView(frame: .zero,
                                               collectionViewLayout: layout).then {
        $0.backgroundColor = .white
    }
    
    let confirmButton = GreenButton().then {
        $0.configureButton(fontColor: .white, font: .pretendard(size: 18, weight: .bold), text: "기록 완료")
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        [travelInfoStackView,
         travelTitleLabel,
         borderLine,
         recordView,
         photoButtonView,
         collectionView,
         confirmButton].forEach { self.addSubview($0) }
        
        [periodLabel,
         separatorLabel,
         locationImageView,
         areaLabel].forEach { travelInfoStackView.addArrangedSubview($0) }
        
        [recordTitleLabel,
         memoryTextView].forEach { recordView.addSubview($0) }
        
        [photoButtonImageView,
         photoButtonLabelStackView,
         photoButton].forEach { photoButtonView.addSubview($0) }
        
        [photoCountLabel,
         photoTotalLabel].forEach { photoButtonLabelStackView.addArrangedSubview($0) }
    }
    
    override func configureConstraints() {
        let horizontalInset = CGFloat(24)
        
        travelInfoStackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(horizontalInset)
        }
        
        locationImageView.snp.makeConstraints {
            $0.size.equalTo(12)
        }
        
        travelTitleLabel.snp.makeConstraints {
            $0.top.equalTo(travelInfoStackView.snp.bottom).offset(6)
            $0.horizontalEdges.equalToSuperview().inset(horizontalInset)
        }
        
        borderLine.snp.makeConstraints {
            $0.top.equalTo(travelTitleLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(4)
        }
        
        recordView.snp.makeConstraints {
            $0.top.equalTo(borderLine.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(horizontalInset)
            $0.height.equalTo(208)
        }
        
        recordTitleLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview().offset(16)
        }
        
        memoryTextView.snp.makeConstraints {
            $0.top.equalTo(recordTitleLabel.snp.bottom).offset(8)
            $0.bottom.horizontalEdges.equalToSuperview().inset(16)
        }
        
        photoButtonView.snp.makeConstraints {
            $0.top.equalTo(recordView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(horizontalInset)
            $0.size.equalTo(80)
        }
        
        photoButtonImageView.snp.makeConstraints {
            $0.size.equalTo(36)
            $0.top.equalToSuperview().offset(11.5)
            $0.centerX.equalToSuperview()
        }
        
        photoButtonLabelStackView.snp.makeConstraints {
            $0.top.equalTo(photoButtonImageView.snp.bottom).offset(2)
            $0.centerX.equalToSuperview()
        }
        
        photoButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.bottom.equalTo(photoButtonView)
            $0.leading.equalTo(photoButtonView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(horizontalInset)
            $0.height.equalTo(80)
        }
        
        confirmButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20)
            $0.horizontalEdges.equalToSuperview().inset(horizontalInset)
        }
    }
    
    func bind(travel: Travel) {
        areaLabel.text = travel.area
        periodLabel.text = String(startDate: travel.startDate, endDate: travel.endDate)
        travelTitleLabel.text = travel.title
        memoryTextView.text = travel.memory
        updatePhotoCount(count: travel.photos.count)
        isTextViewEmpty() ? setTextViewPlaceHolder() : (memoryTextView.textColor = UIColor.black)
    }
    
    func updatePhotoCount(count: Int) {
        if count == 0 {
            photoCountLabel.configureLabel(color: .gray80, font: .pretendard(size: 16, weight: .regular), text: "0")
        } else {
            photoCountLabel.configureLabel(color: .green100, font: .pretendard(size: 16, weight: .medium), text: String(count))
        }
    }
    
    private func isTextViewEmpty() -> Bool {
        let text = memoryTextView.text ?? ""
        let isPlaceholder = text == placeHolder
        return text.isEmpty || isPlaceholder ? true : false
    }
    
    private func setTextViewPlaceHolder() {
        memoryTextView.text = placeHolder
        memoryTextView.textColor = UIColor.gray80
    }
    
    func configureConfirmButton() {
        if isTextViewEmpty() {
            confirmButton.isEnabled = false
            confirmButton.backgroundColor = .green10
        } else {
            confirmButton.isEnabled = true
            confirmButton.backgroundColor = .green100
        }
    }
    
    func setBeginText(textView: UITextView) {
        if isTextViewEmpty() {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func setEndText(textView: UITextView) {
        if isTextViewEmpty() {
            setTextViewPlaceHolder()
        }
    }
}
