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
    
    fileprivate let dependencies: Dependencies
    fileprivate let window: UIWindow
    
    init(dependencies: Dependencies, window: UIWindow) {
        self.window = window
        self.dependencies = dependencies
    }
    
    override func start() -> Observable<LoginCoordinationResult> {
        let viewController = LoginViewController()
        let attachableViewModel: Attachable<LoginViewModel> = .detached(dependencies)
        let viewModel = viewController.attach(wrapper: attachableViewModel)
        
        let logInResult = viewModel.logInSelection
            .do(onNext: { _ in print("Log In Tap") })
            .map({ _ in LoginCoordinationResult.failure })
        
        window.setRootViewController(viewController)
        
        return logInResult
            .filter({ $0 != .failure })
            .take(1)
    }
    
}
