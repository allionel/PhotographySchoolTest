//
//  UIView+Extension.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/4/23.
//

import Foundation
import UIKit
import SwiftUI

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

extension UIView {
    var visible: Bool {
        get { !isHidden }
        set {
            isHidden = !newValue
            alpha = newValue ? 1 : 0
        }
    }
}

extension UIView {
    func addConstraint(to superView: UIView, on edge: Edge.Set, with constant: CGFloat = .zero) {
        switch edge {
        case .top:
            topAnchor.constraint(equalTo: superView.topAnchor, constant: constant).isActive = true
        case .bottom:
            bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: constant).isActive = true
        case .leading:
            leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: constant).isActive = true
        case .trailing:
            trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: constant).isActive = true
        case .vertical:
            topAnchor.constraint(equalTo: superView.topAnchor, constant: -constant).isActive = true
            bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: constant).isActive = true
        case .horizontal:
            leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: constant).isActive = true
            trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -constant).isActive = true
        case .all:
            fill(to: superView, with: constant)
        default:
            break
        }
    }
    
    func fill(to superView: UIView, with constant: CGFloat = .zero) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.topAnchor, constant: constant),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: constant),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: constant),
            leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: constant),
        ])
    }
}
