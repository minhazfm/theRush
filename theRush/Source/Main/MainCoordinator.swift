//
//  MainCoordinator.swift
//  theRush
//
//  Created by Minhaz Mohammad on 8/28/19.
//  Copyright © 2019 SMPL Inc. All rights reserved.
//

import RxSwift
import UIKit

enum MainCoordinationResult {
    case home
    case settings
    case signOut
}

final class MainCoordinator: BaseCoordinator<MainCoordinationResult> {
    
    typealias Dependencies = HasUserService
    
    fileprivate let dependencies: Dependencies
    fileprivate let window: UIWindow
    
    init(dependencies: Dependencies, window: UIWindow) {
        self.dependencies = dependencies
        self.window = window
    }
    
    override func start() -> Observable<MainCoordinationResult> {
        let viewController = MainViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let attachableViewModel: Attachable<MainViewModel> = .detached(dependencies)
        let viewModel = viewController.attach(wrapper: attachableViewModel)
        
        let logOutResult = viewModel.logOutSelection
            .do(onNext: { _ in print("Log Out Tap") })
            .map({ _ in MainCoordinationResult.signOut })
        
        window.setRootViewController(navigationController)
        
        return logOutResult
            .filter({ $0 == .signOut })
            .take(1)
    }
    
}
