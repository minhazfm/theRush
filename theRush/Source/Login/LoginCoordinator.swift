//
//  LoginCoordinator.swift
//  theRush
//
//  Created by Minhaz Mohammad on 8/28/19.
//  Copyright © 2019 SMPL Inc. All rights reserved.
//

import RxSwift
import UIKit

final class LoginCoordinator: BaseCoordinator<Void> {
    
    typealias Dependencies = HasUserService
    
    fileprivate let window: UIWindow
    fileprivate let dependencies: Dependencies
    
    init(window: UIWindow, dependencies: Dependencies) {
        self.window = window
        self.dependencies = dependencies
    }
    
    override func start() -> Observable<Void> {
        let viewController = LoginViewController()
        let attachableViewModel: Attachable<LoginViewModel> = .detached(dependencies)
        let viewModel = viewController.attach(wrapper: attachableViewModel)
        
        window.setRootViewController(viewController)
        
        return viewModel.loginSelection
            .take(1)
    }
    
}
