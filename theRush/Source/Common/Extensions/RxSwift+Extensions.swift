//
//  RxSwift+Extensions.swift
//  theRush
//
//  Created by Minhaz Mohammad on 8/28/19.
//  Copyright © 2019 SMPL Inc. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RxRelay

extension ObservableType {
    
    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver(onErrorRecover: { _ in
            return Driver.empty()
        })
    }
    
    func mapToVoid() -> Observable<Void> {
        return map({ _ in })
    }
    
    func unwrap<T>() -> Observable<T> where Element == T? {
        return filter({ $0 != nil }).map({ $0! })
    }
    
}

extension Observable where Element: Sequence, Element.Iterator.Element: ModelConvertibleType {
    typealias ModelType = Element.Iterator.Element.ModelType
    
    func mapToModel() -> Observable<[ModelType]> {
        return map({ sequence -> [ModelType] in
            return sequence.mapToModel()
        })
    }
}

extension Sequence where Iterator.Element: ModelConvertibleType {
    typealias Element = Iterator.Element
    
    func mapToModel() -> [Element.ModelType] {
        return map({
            return $0.asModel()
        })
    }
}
