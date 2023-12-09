//
//  Device.swift
//  OrientatonToggleFlow
//
//  Created by Sports Dad on 11/8/23.
//

import UIKit

class Device {
    
    let widthPortrait: Float
    let heightPortrait: Float
    let widthLandscape: Float
    let heightLandscape: Float
    
    var isPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    var isPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
    
    init() {
        
        let _screenWidth = Float(Int(UIScreen.main.bounds.size.width + 0.5))
        let _screenHeight = Float(Int(UIScreen.main.bounds.size.height + 0.5))
        
        widthPortrait = _screenWidth < _screenHeight ? _screenWidth : _screenHeight
        heightPortrait = _screenWidth < _screenHeight ? _screenHeight : _screenWidth
        
        widthLandscape = heightPortrait
        heightLandscape = widthPortrait
        
        print("Device Portrait  [\(String(format: "%.1f", widthPortrait)) x \(String(format: "%.1f", heightPortrait))]")
        print("Device Landscape [\(String(format: "%.1f", widthLandscape)) x \(String(format: "%.1f", heightLandscape))]")
    }
}
