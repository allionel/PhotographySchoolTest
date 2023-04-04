//
//  LessonDetailViewController.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/4/23.
//

import UIKit
import SwiftUI

final class LessonDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupBarButtonItem()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupBarButtonItem()
    }
    
    private func setupBarButtonItem() {
        let button: DownloadBarButton = .init {
            // did tap
        }
        navigationController?.navigationItem.rightBarButtonItem = button
    }
}

final class DownloadBarButton: UIBarButtonItem {
    private let uiButton: UIButton = .init()

    init(action: @escaping () -> Void) {
        let image = UIImage(systemName: .downloadIcon)
        uiButton.setTitle(String.space + String.download.localized, for: .normal)
        uiButton.setImage(image, for: .normal)
        uiButton.setTitleColor(.systemBlue, for: .normal)
        uiButton.addAction { action() }
        super.init(customView: uiButton)
    }
    
    private override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



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
