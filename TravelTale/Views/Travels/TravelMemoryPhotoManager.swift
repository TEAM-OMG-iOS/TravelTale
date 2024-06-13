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
    
    var photoResults: [PHPickerResult] = [] // 메모리 절약을 위해 UIImage 대신 PHPickerResult를 저장
    private var imageCache: (identifier: String, image: UIImage)?
    // ㄴ TODO: imageCache를 [String:UIImage]로 변경
        // 목적: 중복되는 UIImage load를 줄이기 위해
    
    func loadImage(for result: PHPickerResult, completion: @escaping (UIImage?) -> Void) {
        // TODO: [코드 추가] imageCache 배열에 있는 이미지라면 아래 실행하지 않고 리턴
        /* 
         if ~~~~ {
            completion(image)
            return
        }
         */
       
        let itemProvider = result.itemProvider
        if itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
                guard let self = self else { return }
                if let image = object as? UIImage {
                    if let identifier = result.assetIdentifier {
                        self.imageCache = (identifier, image)
                    }
                    completion(image)
                } else {
                    print("[Fail]: itemProvider -> UIImage")
                    completion(nil)
                }
            }
        } else {
            print("[Fail]: itemProvider.canLoadObject")
            completion(nil)
        }
    }
    
    func clearPhotoResults() {
        photoResults.removeAll()
    }
}
