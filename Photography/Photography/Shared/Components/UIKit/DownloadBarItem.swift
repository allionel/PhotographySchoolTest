//
//  DownloadBarItem.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/6/23.
//

import UIKit

final class DownloadBarItem: UIView {
    let progressSize: CGFloat
    private var didPressDownload: (() -> Void)?
    private let animationDuration: TimeInterval = 0.25
    
    var viewState: DownloadState = .ready {
        didSet { updateView() }
    }
    
    var downloadProgress: Double = .zero {
        didSet {
            progressView.progress = Float(downloadProgress)
        }
    }
    
    private var itemBarStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var progressView: CircularProgressView = {
        let view: CircularProgressView = .init(size: progressSize)
        view.progressColor = .systemBlue
        view.trackColor = .darkGray
        view.alpha = .zero
        return view
    }()
    
    private lazy var downloadBarButton: DownloadBarButton = {
        let button = DownloadBarButton()
        return button
    }()
    
    private lazy var doneImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init(systemName: .finishDownload)
        imageView.tintColor = .systemBlue
        return imageView
    }()
    
    private override init(frame: CGRect) {
        progressSize = .zero
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError(String.initCoderFatalError)
    }
    
    init(progressSize: CGFloat) {
        self.progressSize = progressSize
        super.init(frame: .zero)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .clear
        setupStackView()
        itemBarStackView.addArrangedSubview(doneImageView)
        itemBarStackView.addArrangedSubview(progressView)
        itemBarStackView.addArrangedSubview(downloadBarButton)
        downloadBarButton.didTap {
            self.didPressDownload?()
        }
        updateView()
    }
    
    private func setupStackView() {
        addSubview(itemBarStackView)
        itemBarStackView.translatesAutoresizingMaskIntoConstraints = false
        itemBarStackView.fill(to: self)
    }
    
    private func updateView() {
        UIView.animate(withDuration: self.animationDuration, delay: .zero) { [self] in
            downloadBarButton.visible = viewState.visible.ready
            progressView.visible = viewState.visible.downloading
            doneImageView.visible = viewState.visible.done
        }
    }
    
    func didTapDownload(action: (() -> Void)?) {
        didPressDownload = action
    }
}
