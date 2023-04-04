//
//  VideoPlayer.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/5/23.
//

import Foundation
import AVFoundation
import AVKit

final class VideoPlayerViewController: AVPlayerViewController {
    
    private var videoPath: String = "" {
        didSet { }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

final class VideoPlayer: UIView {
    private lazy var playerControler: VideoPlayerViewController = .init()
    private var player: AVPlayer?
    private var onTapPlayButton: (() -> Void)?
    private let playButtonSize: CGFloat = 44
    
    private lazy var playImageView: UIImageView = {
        let image: UIImage = .init(systemName: .playIcon)!
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        return imageView
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .caption
        return button
    }()
    
    // Must be set to move to parent controller
    weak var parent: UIViewController? {
        didSet {
            parent?.addChild(playerControler)
            playerControler.didMove(toParent: parent)
        }
    }
    
    // Must be set to show the video
    var videoPath: String  = "" {
        didSet {
            guard let url: URL = .init(string: videoPath) else { return }
            player = .init(url: url)
            playerControler.player = player
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        setupPlayerController()
        setupPlayButton()
        setupButtonImageView()
        setupPlayAction()
    }
    
    private func setupPlayerController() {
        addSubview(playerControler.view)
        playerControler.view.frame = bounds
        playerControler.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func setupPlayButton() {
        addSubview(playButton)
        NSLayoutConstraint.activate([
            playButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            playButton.widthAnchor.constraint(equalToConstant: playButtonSize),
            playButton.heightAnchor.constraint(equalToConstant: playButtonSize)
        ])
    }
    
    private func setupButtonImageView() {
        playButton.addSubview(playImageView)
        playImageView.fill(to: playButton)
    }
    
    private func setupPlayAction() {
        playButton.addAction { [weak self] in
            self?.player?.play()
            self?.playButton.isHidden = true
        }
    }
}
