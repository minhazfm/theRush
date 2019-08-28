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
    
    var userAuthenticationState: UserAuthenticationState = .signedOut
    
    // MARK: - Init
    init() {
        print("UserService init")
    }
    
    deinit {
        print("UserService deinit")
    }
    
}
