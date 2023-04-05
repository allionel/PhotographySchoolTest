//
//  DownloadBarButton.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/4/23.
//

import UIKit

final class DownloadBarButton: UIButton {
    private let uiButton: UIButton = .init()
    private var didPress: (() -> Void)?
    
    convenience init() {
        self.init(frame: .zero)
        let image = UIImage(systemName: .downloadIcon)
        setTitle(String.space + String.download.localized, for: .normal)
        setImage(image, for: .normal)
        setTitleColor(.systemBlue, for: .normal)
        addTarget(self, action: #selector(actionHandler), for: .touchUpInside)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func actionHandler() { didPress?() }
    
    func didTap(action: (() -> Void)?) {
        didPress = action
    }
}
