//
//  HighlightButton.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/7/23.
//

import UIKit

class HighlightButton: UIButton {
    public override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.1) { [self] in
                transform = isHighlighted ? .init(scaleX: 0.95, y: 0.95) : .identity
            }
        }
    }
}
