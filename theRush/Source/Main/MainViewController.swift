//
//  MainViewController.swift
//  theRush
//
//  Created by Minhaz Mohammad on 8/28/19.
//  Copyright © 2019 SMPL Inc. All rights reserved.
//

import RxCocoa
import RxSwift
import NVActivityIndicatorView
import UIKit

enum MainDisplayMode {
    case sideBySide
    case slideInMenu
}

enum SideMenuState {
    case closed
    case open
}

final class ContainerView: UIView {
    
    var contentView: UIView? {
        willSet {
            contentView?.removeFromSuperview()
        }
        
        didSet {
            guard let contentView = contentView else { return }
            addSubview(contentView)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView?.frame = bounds
    }
    
}

final class MainViewController: UIViewController, ViewModelAttachingProtocol {

    // MARK: - Conformance to ViewModelAttachingProtocol
    var bindings: MainViewModel.Bindings {
        return MainViewModel.Bindings(logOutButtonTap: logOutButtonItem.rx.tap.asObservable())
    }
    
    var viewModel: Attachable<MainViewModel>!
    
    
    // MARK: - Logic Variables
    var displayMode: MainDisplayMode = .slideInMenu
    
    fileprivate let disposeBag = DisposeBag()
    
    fileprivate let tabBarContainerExpandedOffset: CGFloat = 60.0
    
    fileprivate var sideMenuColumnWidth: CGFloat = 315.0
    
    fileprivate var sideMenuState: SideMenuState = .closed
    
    
    // MARK: - UI Variables
    fileprivate lazy var logOutButtonItem: UIBarButtonItem = {
        let buttonItem = UIBarButtonItem(title: "Log Out",
                                         style: .plain,
                                         target: self,
                                         action: nil)
        buttonItem.tintColor = .white
        return buttonItem
    }()
    
//    lazy var inProgressIndicatorView: NVActivityIndicatorView = {
//
//    }()
    
    fileprivate lazy var sideMenuContainerView: ContainerView = {
        let containerView = ContainerView()
        return containerView
    }()
    
    fileprivate lazy var sideMenuSwipeGestureRecognizer: UIPanGestureRecognizer = {
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        gestureRecognizer.delegate = self
        return gestureRecognizer
    }()
    
    fileprivate lazy var tapToCloseGestureRecognizer: UITapGestureRecognizer = {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        gestureRecognizer.delegate = self
        return gestureRecognizer
    }()
    
    fileprivate lazy var tabBarContainerView: ContainerView = {
        let containerView = ContainerView()
        return containerView
    }()
    
    func configureReactiveBinding(viewModel: MainViewModel) -> MainViewModel {
        return viewModel
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .yellow
        navigationItem.rightBarButtonItem = logOutButtonItem
    }

}

extension MainViewController: UIGestureRecognizerDelegate {
    
    @objc fileprivate func handleTap(_ recognizer: UITapGestureRecognizer) {
        
    }
    
    @objc fileprivate func handleSwipe(_ recognizer: UIPanGestureRecognizer) {
        
    }
    
}
