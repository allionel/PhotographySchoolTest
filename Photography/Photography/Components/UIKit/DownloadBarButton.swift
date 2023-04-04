//
//  DownloadBarButton.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/4/23.
//

import UIKit

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
