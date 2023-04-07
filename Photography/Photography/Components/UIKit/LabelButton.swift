//
//  LabelButton.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/7/23.
//

import UIKit

final class LabelButton: HighlightButton {
    enum Direction {
        case left
        case right
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isUserInteractionEnabled = false
        stackView.axis = .horizontal
        stackView.spacing = .interlineSpacing
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = false
        label.font = .regularBody
        label.textColor = .systemBlue
        return label
    }()
    
    private lazy var imgView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.tintColor = .systemBlue
        return imageView
    }()
    
    let direction: Direction
    
    var title: String = "" {
        didSet { label.text = title }
    }
    
    var image: String = "" {
        didSet { imgView.image = .init(systemName: image) }
    }
    
    init(direction: Direction) {
        self.direction = direction
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError(String.initCoderFatalError)
    }
    
    private func commonInit() {
        setTitle("", for: .normal)
        addSubview(stackView)
        stackView.fill(to: self)
        setupElements()
    }
    
    private func setupElements() {
        switch direction {
        case .right:
            stackView.addArrangedSubview(label)
            stackView.addArrangedSubview(imgView)
        case .left:
            stackView.addArrangedSubview(imgView)
            stackView.addArrangedSubview(label)
        }
    }
}


extension UIView {
    static func spacer(size: CGFloat = 10, for layout: NSLayoutConstraint.Axis = .horizontal) -> UIView {
        let spacer = UIView()
        if layout == .horizontal {
            spacer.widthAnchor.constraint(greaterThanOrEqualToConstant: size).isActive = true
        } else {
            spacer.heightAnchor.constraint(greaterThanOrEqualToConstant: size).isActive = true
        }
        return spacer
    }
}


