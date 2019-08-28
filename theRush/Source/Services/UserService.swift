//
//  UserService.swift
//  theRush
//
//  Created by Minhaz Mohammad on 8/28/19.
//  Copyright © 2019 SMPL Inc. All rights reserved.
//

import Foundation
import RxRelay
import RxSwift

enum UserAuthenticationState {
    case signedIn
    case signedOut
}

protocol UserServiceProtocol {
    var userInstance: BehaviorRelay<User?> { get }
}

final class UserService: UserServiceProtocol {
    
    // MARK: - Logic variables
    fileprivate(set) var userInstance = BehaviorRelay<User?>(value: nil)
    
    var authenticationState: UserAuthenticationState = .signedOut
    
    // MARK: - Init
    init() {
        print("UserService init")
    }
    
    func toggleAuthentication() {
        authenticationState = authenticationState == .signedIn ? .signedOut : .signedIn
    }
    
    deinit {
        print("UserService deinit")
    }
    
}

extension Reactive where Base: UserService {
    
//    func toggleAuthentication() -> Observable<Void> {
//        return Observable.create({ (observer) -> Disposable in
//            let currentState = self.base.authenticationState
//            self.base.authenticationState = currentState == .signedIn ? .signedOut : .signedIn
//
//            observer.onNext(())
//            observer.onCompleted()
//
//            return Disposables.create()
//        })
//    }
    
}
