//
//  RootViewModel.swift
//  OrientatonToggleFlow
//
//  Created by Sports Dad on 11/8/23.
//

import UIKit

final class RootViewModel {
    let applicationController: ApplicationController
    var orientation: Orientation
    let window: UIWindow
    let windowScene: UIWindowScene
    init(applicationController: ApplicationController,
         orientation: Orientation,
         window: UIWindow,
         windowScene: UIWindowScene) {
        self.applicationController = applicationController
        self.orientation = orientation
        self.window = window
        self.windowScene = windowScene
    }
    
    var device: Device { applicationController.device }
    
}
