//
//  AppDelegate.swift
//  theRush
//
//  Created by Minhaz Mohammad on 8/28/19.
//  Copyright © 2019 SMPL Inc. All rights reserved.
//

import UIKit
import CoreData
import RxRelay
import RxSwift

enum AppState {
    case didFinishLaunching
    case willResignActive
    case didEnterBackground
    case willEnterForeground
    case didBecomeActive
    case willTerminate
}

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    fileprivate lazy var appCoordinator: AppCoordinator = {
        let coordinator = AppCoordinator(window: window!)
        return coordinator
    }()
    
    fileprivate let appStateRelay = PublishRelay<AppState>()
    
    fileprivate let disposeBag = DisposeBag()
    
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Create UIWindow within the screen boundaries.
        window = UIWindow(frame: UIScreen.main.bounds)
        
        appCoordinator.start()
            .subscribe()
            .disposed(by: disposeBag)
        
        appStateRelay.accept(.didFinishLaunching)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        appStateRelay.accept(.willResignActive)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        appStateRelay.accept(.didEnterBackground)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        appStateRelay.accept(.willEnterForeground)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        appStateRelay.accept(.didBecomeActive)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        appStateRelay.accept(.willTerminate)
//        self.saveContext()
    }

}

extension Reactive where Base: AppDelegate {
    
    var appState: Observable<AppState> {
        return base.appStateRelay.asObservable()
    }
    
}
