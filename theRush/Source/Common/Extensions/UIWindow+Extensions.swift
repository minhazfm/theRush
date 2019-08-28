//
//  UIWindow+Extensions.swift
//  theRush
//
//  Created by Minhaz Mohammad on 8/28/19.
//  Copyright © 2019 SMPL Inc. All rights reserved.
//

import UIKit

extension UIWindow {
    
    struct FadeInTransitionOptions {
        
        var animation: CATransition {
            let transition = CATransition()
            transition.type = .fade
            transition.subtype = nil
            transition.duration = transitionDuration
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
            return transition
        }
        var transitionDuration: TimeInterval
        
        init(transitionDuration: TimeInterval = 0.3) {
            self.transitionDuration = transitionDuration
        }
        
    }
    
    func setRootViewController(_ controller: UIViewController) {
        let backgroundView: UIView = controller.view
        let options: FadeInTransitionOptions = FadeInTransitionOptions()
        let transitionWindow: UIWindow? = nil
        
        transitionWindow?.rootViewController = UIViewController.newController(withView: backgroundView, frame: transitionWindow!.bounds)
        transitionWindow?.makeKeyAndVisible()
        
        layer.add(options.animation, forKey: kCATransition)
        rootViewController = controller
        makeKeyAndVisible()
        
        if let window = transitionWindow {
            DispatchQueue.main.asyncAfter(deadline: (.now() + 1 + options.transitionDuration), execute: {
                window.removeFromSuperview()
            })
        }
    }
    
//    static func topMostViewController(with rootViewController: UIViewController!) -> UIViewController? {
//        guard var rootVC = rootViewController else {
//            return nil
//        }
//        
//        if !rootVC.children.isEmpty, let mainTabBarRoot = rootVC.children.filter({ $0 is MainTabBarController }).first {
//            rootVC = mainTabBarRoot
//        }
//        
//        if rootVC.isKind(of: UITabBarController.self), let vc = rootVC as? UITabBarController {
//            return topMostViewController(with: vc.selectedViewController)
//        }
//        else if rootVC.isKind(of: UINavigationController.self), let vc = rootVC as? UINavigationController {
//            return topMostViewController(with: vc.visibleViewController)
//        }
//        else if let vc = rootVC.presentedViewController {
//            return topMostViewController(with: vc.presentedViewController)
//        }
//        
//        return rootVC
//    }
    
}

extension UIViewController {
    
    static func newController(withView view: UIView, frame: CGRect) -> UIViewController {
        view.frame = frame
        let controller = UIViewController()
        controller.view = view
        return controller
    }
    
}
