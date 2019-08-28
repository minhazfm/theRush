//
//  MainViewModel.swift
//  theRush
//
//  Created by Minhaz Mohammad on 8/28/19.
//  Copyright © 2019 SMPL Inc. All rights reserved.
//

import Foundation
import RxSwift

final class MainViewModel: ViewModelProtocol {
    
    typealias Dependency = HasUserService
    
    struct Bindings {
        let logOutButtonTap: Observable<Void>
    }
    
    let logOutSelection: Observable<Void>
    
    init(dependency: Dependency, bindings: Bindings) {
        logOutSelection = bindings.logOutButtonTap
    }
    
    deinit {
        print("MainViewModel deinit")
    }
    
}
