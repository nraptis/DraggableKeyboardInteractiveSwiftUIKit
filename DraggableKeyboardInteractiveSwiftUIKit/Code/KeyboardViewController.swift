//
//  KeyboardViewController.swift
//  DraggableKeyboardInteractiveSwiftUIKit
//
//  Created by Sports Dad on 12/9/23.
//

import UIKit

class KeyboardViewController: UIViewController {
    
    let keyboardHandler = KeyboardHandler()
    
    public var tapGesture: UITapGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        if let tapGesture = tapGesture {
            tapGesture.cancelsTouchesInView = false
            view.addGestureRecognizer(tapGesture)
            tapGesture.isEnabled = true
            tapGesture.delegate = self
        }
        
        keyboardHandler.willExpandHandler = { [weak self] height, duration, animationOptions in
            self?.keyboardWillExpand(height: height, duration: duration, animationOptions: animationOptions)
        }
        
        keyboardHandler.willCollapseHandler = { [weak self] duration, animationOptions in
            self?.keyboardWillCollapse(duration: duration, animationOptions: animationOptions)
        }
    }
    
    func keyboardWillExpand(height: CGFloat, duration: TimeInterval, animationOptions: UIView.AnimationOptions) {
        
    }
    
    func keyboardWillCollapse(duration: TimeInterval, animationOptions: UIView.AnimationOptions) {
        
    }
    
    @objc func dismissKeyboard() {
        for subview1 in view.subviews {
            subview1.resignFirstResponder()
            for subview2 in subview1.subviews {
                subview2.resignFirstResponder()
                for subview3 in subview2.subviews {
                    subview3.resignFirstResponder()
                    for subview4 in subview3.subviews {
                        subview4.resignFirstResponder()
                        for subview5 in subview4.subviews {
                            subview5.resignFirstResponder()
                        }
                    }
                }
            }
        }
    }
    
    func shouldViewControllerAllowKeyboardTapDismiss(_ viewController: UIViewController) -> Bool {
        return true
    }
    
    func shouldViewAllowKeyboardTapDismiss(_ view: UIView) -> Bool {
        if view is UIButton {
            return false
        }
        if view is UITextField {
            return false
        }
        if view is UITextView {
            return false
        }
        return true
    }
}

extension UIView {
    func getViewController() -> UIViewController? {
        var responder = self.next
        while var _responder = responder {
            if let viewController = _responder as? UIViewController {
                return viewController
            }
            responder = _responder.next
        }
        return nil
    }
}

extension KeyboardViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        if var touchView = touch.view {
            var viewList = [UIView]()
            while true {
                viewList.append(touchView)
                if let parent = touchView.superview {
                    touchView = parent
                } else {
                    break
                }
            }
            
            for view in viewList {
                if !shouldViewAllowKeyboardTapDismiss(view) {
                    return false
                }
                if let viewController = view.getViewController() {
                    if !shouldViewControllerAllowKeyboardTapDismiss(viewController) {
                        return false
                    }
                }
            }
        }
        return true
    }
}
