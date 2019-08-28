//
//  LoginCoordinator.swift
//  theRush
//
//  Created by Minhaz Mohammad on 8/28/19.
//  Copyright © 2019 SMPL Inc. All rights reserved.
//

import RxSwift
import UIKit

enum LoginCoordinationResult {
    case failure
    case success
}

final class LoginCoordinator: BaseCoordinator<LoginCoordinationResult> {
    
    typealias Dependencies = HasUserService
    
    fileprivate let window: UIWindow
    fileprivate let dependencies: Dependencies
    
    init(window: UIWindow, dependencies: Dependencies) {
        self.window = window
        self.dependencies = dependencies
    }
    
    override func start() -> Observable<LoginCoordinationResult> {
        let viewController = LoginViewController()
        let attachableViewModel: Attachable<LoginViewModel> = .detached(dependencies)
        let viewModel = viewController.attach(wrapper: attachableViewModel)
        
        let loginResult = viewModel.loginSelection
            .do(onNext: { _ in print("Tap") })
            .map({ _ in LoginCoordinationResult.failure })
        
        window.setRootViewController(viewController)
        
        return loginResult
            .filter({ $0 != .failure })
            .take(1)
    }
    
}
