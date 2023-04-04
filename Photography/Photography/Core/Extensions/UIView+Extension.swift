//
//  UIView+Extension.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/4/23.
//

import Foundation
import class UIKit.UIView
import class UIKit.UITapGestureRecognizer

extension UIView {
    struct AssociatedKeys {
        static var actionState: UInt8 = 0
    }
    
    public typealias ActionTap = () -> Void
    
    private var actionTap: ActionTap? {
        get {
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.actionState) as? ActionTap else {
                return nil
            }
            return value
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.actionState, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            didTap()
        }
    }
    
    public func addAction(_ action: ActionTap?) {
        actionTap = action
    }
    
    private func didTap() {
        let tapGesture: UITapGestureRecognizer = .init(target: self, action: #selector(handleTap(_:)))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        actionTap?()
    }
}
