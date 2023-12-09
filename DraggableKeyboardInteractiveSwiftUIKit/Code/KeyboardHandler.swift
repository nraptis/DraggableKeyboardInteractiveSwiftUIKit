//
//  KeyboardHandler.swift
//  DraggableKeyboardInteractiveSwiftUIKit
//
//  Created by Sports Dad on 12/9/23.
//

import UIKit

class KeyboardHandler: NSObject {
    
    private var _isKeyboardVisible: Bool = false
    private var _keyboardHeight: CGFloat = 0.0
    
    public var willExpandHandler: ((_ : CGFloat, _ : TimeInterval, _ : UIView.AnimationOptions) -> Void)?
    public var willCollapseHandler: ((_ :  TimeInterval, _ : UIView.AnimationOptions) -> Void)?
    
    private static var resizeThreshold: CGFloat = 8.0

    public override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidChangeHeight), name: UIResponder.keyboardDidChangeFrameNotification, object: nil)
    }

    static func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        _isKeyboardVisible = true
        guard let info = notification.userInfo else { return }
        guard let sizeValue = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        guard let optionsValue = info[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber else { return }
        guard let durationValue = info[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
        let keyboardSize = sizeValue.cgRectValue
        let options = UIView.AnimationOptions(rawValue: optionsValue.uintValue)
        let duration = TimeInterval(durationValue.floatValue)
        if CGFloat(fabsf(Float(keyboardSize.height - _keyboardHeight))) < KeyboardHandler.resizeThreshold {
            return
        }
        _keyboardHeight = keyboardSize.height
        willExpandHandler?(keyboardSize.height, duration, options)
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        guard _isKeyboardVisible else { return }
        _keyboardHeight = 0.0
        _isKeyboardVisible = false
        guard let info = notification.userInfo else { return }
        guard let optionsValue = info[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber else { return }
        guard let durationValue = info[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
        let options = UIView.AnimationOptions(rawValue: optionsValue.uintValue)
        let duration = TimeInterval(durationValue.floatValue)
        self.willCollapseHandler?(duration, options)
    }

    @objc func keyboardDidChangeHeight(notification: NSNotification) {
        guard _isKeyboardVisible else { return }
        guard let info = notification.userInfo else { return }
        guard let sizeValue = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        guard let optionsValue = info[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber else { return }
        guard let durationValue = info[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
        let keyboardSize = sizeValue.cgRectValue
        let options = UIView.AnimationOptions(rawValue: optionsValue.uintValue)
        let duration = TimeInterval(durationValue.floatValue)
        if CGFloat(fabsf(Float(keyboardSize.height - _keyboardHeight))) < KeyboardHandler.resizeThreshold {
            return
        }
        _keyboardHeight = keyboardSize.height
        self.willExpandHandler?(keyboardSize.height, duration, options)
    }
}
