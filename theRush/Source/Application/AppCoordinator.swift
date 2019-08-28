//
//  AppCoordinator.swift
//  theRush
//
//  Created by Minhaz Mohammad on 8/28/19.
//  Copyright © 2019 SMPL Inc. All rights reserved.
//

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
    
}
