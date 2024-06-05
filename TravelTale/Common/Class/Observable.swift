//
//  Observable.swift
//  TravelTale
//
//  Created by 유림 on 6/5/24.
//

import Foundation

class Observable<T> { // T: 무슨 타입인지 같이 명시하기 위해. 여러 타입이 될 수 있어서 제네릭으로 선언
    
    var value: T {
        didSet {
//            print("나 바뀜!", value) // 변화를 print하기 위해 사용
            listener?(value) // didset을 통해 이 값이 변경되면 listener에게 알림
        }
    }
    
    private var listener: ((T) -> Void)? // 클로저 자체의 타입만 선언. 초기화를 안하고 옵셔널로 선언
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value) //
        listener = closure
    }
}
