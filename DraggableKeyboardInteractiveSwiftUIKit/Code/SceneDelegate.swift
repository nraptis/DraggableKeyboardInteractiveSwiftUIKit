//
//  SceneDelegate.swift
//  OrientatonToggleFlow
//
//  Created by Sports Dad on 11/8/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        guard let window = window else { return }
        let orientation = Orientation(interfaceOrientation: windowScene.interfaceOrientation)
        let device = Device()
        let applicationController = ApplicationController(device: device)
        ApplicationController.rootViewModel = RootViewModel(applicationController: applicationController,
                                                            orientation: orientation,
                                                            window: window,
                                                            windowScene: windowScene)
        ApplicationController.rootViewController = RootViewController(rootViewModel: ApplicationController.rootViewModel)
        
        
        let homeViewController = HomeViewController(nibName: nil, bundle: nil)
        ApplicationController.rootViewController.push(viewController: homeViewController,
                                                      fromOrientation: orientation,
                                                      toOrientation: orientation,
                                                      fixedOrientation: false,
                                                      animated: false,
                                                      reversed: false)
        window.rootViewController = ApplicationController.rootViewController
        window.makeKeyAndVisible()
    }
    
}

