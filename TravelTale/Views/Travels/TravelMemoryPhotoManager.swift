//
//  TravelMemoryPhotoManager.swift
//  TravelTale
//
//  Created by 유림 on 6/13/24.
//

import PhotosUI

class TravelMemoryPhotoManager {
    static let shared = TravelMemoryPhotoManager()
    private init() {}
    
    // 메모리 절약을 위해 PHPickerResult를 저장
    // 빠른 이미지 로드를 위해 이미지가 필요한 상황에서만 UIImage를 imageCache에 저장
    var photoResults: [PHPickerResult] = []
    private var imageCache: [String:UIImage] = [:]
    
    func loadImage(for result: PHPickerResult, completion: @escaping (UIImage?) -> Void) {
        if let identifier = result.assetIdentifier,
           let cachedImage = imageCache[identifier] {
            completion(cachedImage)
            return
        }
        
        let itemProvider = result.itemProvider
        if itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
                guard let self = self else { return }
                if let image = object as? UIImage {
                    if let identifier = result.assetIdentifier {
                        self.imageCache[identifier] = image
                    }
                    completion(image)
                } else {
                    print("[Fail] itemProvider -> UIImage")
                    completion(nil)
                }
            }
        } else {
            print("[Fail] itemProvider.canLoadObject")
            completion(nil)
        }
        
    }
    
}
