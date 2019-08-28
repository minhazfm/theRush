//
//  LoginViewModel.swift
//  theRush
//
//  Created by Minhaz Mohammad on 8/28/19.
//  Copyright © 2019 SMPL Inc. All rights reserved.
//

import Foundation
import RxSwift

final class LoginViewModel: ViewModelProtocol {
    
    typealias Dependency = HasUserService
    
    struct Bindings {
        let logInButtonTap: Observable<Void>
    }
    
    let logInSelection: Observable<Void>
    
    init(dependency: Dependency, bindings: Bindings) {
        logInSelection = bindings.logInButtonTap
            .do(onNext: { _ in dependency.userService.toggleAuthentication() })
    }
    
    deinit {
        print("LoginViewModel deinit")
    }
    
}
