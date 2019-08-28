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
        let loginButtonTap: Observable<Void>
    }
    
    let loginSelection: Observable<Void>
    
    init(dependency: Dependency, bindings: Bindings) {
        loginSelection = bindings.loginButtonTap
    }
    
    deinit {
        print("LoginViewModel deinit")
    }
    
}
