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
            case .signedIn:
                return presentMainView()
                    .asDriverOnErrorJustComplete()
                    .drive(onNext: { [weak self] authState in
                        self?.coordinateToRoot(with: authState)
                    })
                    .disposed(by: disposeBag)
            
            case .signedOut:
                return presentLoginView()
                    .asDriverOnErrorJustComplete()
                    .drive(onNext: { [weak self] authState in
                        self?.coordinateToRoot(with: authState)
                    })
                    .disposed(by: disposeBag)
        }
    }
    
    fileprivate func presentLoginView() -> Observable<UserAuthenticationState> {
        let loginCoordinator = LoginCoordinator(dependencies: dependencies, window: window)
        return coordinate(to: loginCoordinator)
            .map({ [weak self] _ in
                guard let strongSelf = self else { return .signedOut }
                return strongSelf.dependencies.userService.authenticationState
            })
    }
    
    fileprivate func presentMainView() -> Observable<UserAuthenticationState> {
        let mainCoordinator = MainCoordinator(dependencies: dependencies, window: window)
        return coordinate(to: mainCoordinator)
            .map({ [weak self] _ in
                guard let strongSelf = self else { return .signedOut }
                return strongSelf.dependencies.userService.authenticationState
            })
    }
    
}
