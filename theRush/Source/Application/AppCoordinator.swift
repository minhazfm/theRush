//
//  AppCoordinator.swift
//  theRush
//
//  Created by Minhaz Mohammad on 8/28/19.
//  Copyright © 2019 SMPL Inc. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

protocol HasUserService {
    var userService: UserService { get }
}

struct AppDependency: HasUserService {
    
    let userService: UserService
    
    init() {
        userService = UserService()
    }
    
}

final class AppCoordinator: BaseCoordinator<Void> {
    
    fileprivate let dependencies: AppDependency
    fileprivate let window: UIWindow
    
    init(window: UIWindow) {
        self.dependencies = AppDependency()
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        coordinateToRoot(with: dependencies.userService.authenticationState)
        return Observable.never()
    }
    
}

extension AppCoordinator {
    
    fileprivate func coordinateToRoot(with authenticationState: UserAuthenticationState) {
        switch authenticationState {
            case .signedOut:
                return presentLoginView()
                    .asDriverOnErrorJustComplete()
                    .drive(onNext: { [weak self] authState in
                        self?.window.rootViewController = nil
                        self?.coordinateToRoot(with: authState)
                    })
                    .disposed(by: disposeBag)
            
            default:
                return Observable.of(())
                    .subscribe()
                    .disposed(by: disposeBag)
        }
    }
    
    fileprivate func presentLoginView() -> Observable<UserAuthenticationState> {
        let loginViewCoordinator = LoginCoordinator(window: window, dependencies: dependencies)
        return coordinate(to: loginViewCoordinator)
            .map({ [unowned self] _ in self.dependencies.userService.authenticationState })
    }
    
}
