//
//  LessonDetailViewController.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/4/23.
//

import UIKit
import SwiftUI

final class LessonDetailViewController: UIViewController {
    @ObservedObject private var viewModel: LessonDetailViewModel
    
    private let screenHeight: CGFloat = UIScreen.main.bounds.height
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = .verticalPadding
        stackView.alignment = .leading
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var videoPlayer: VideoPlayer = {
        let player = VideoPlayer()
        player.translatesAutoresizingMaskIntoConstraints = false
        player.parent = self
        return player
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.textColor = .caption
        label.font = .title1
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.textColor = .surface
        label.font = .regularBody
        return label
    }()
    
    init(viewModel: LessonDetailViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        // Navigation needs to be ready because of transition from swiftui view
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            setupUIElement()
            setupBarButtonItem()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupUIElement() {
        setupScrollView()
        setupVideoPlayer()
        setupStackView()
        setupTextViews()
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addConstraint(to: view, on: .horizontal)
        scrollView.addConstraint(to: view, on: .bottom)
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.addSubview(contentView)
        contentView.addConstraint(to: scrollView, on: .vertical)
        contentView.addConstraint(to: scrollView, on: .horizontal)
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1).isActive = true
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        let heightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1)
        heightConstraint.isActive = true
        heightConstraint.priority = .defaultHigh
    }
    
    private func setupVideoPlayer() {
        contentView.addSubview(videoPlayer)
        videoPlayer.videoPath = viewModel.lesson.videoUrl
        let height = 2 * screenHeight / 7
        videoPlayer.heightAnchor.constraint(equalToConstant: height).isActive = true
        videoPlayer.addConstraint(to: contentView, on: .horizontal)
        videoPlayer.addConstraint(to: contentView, on: .top)
    }
    
    private func setupStackView() {
        contentView.addSubview(horizontalStackView)
        horizontalStackView.addConstraint(to: contentView, on: .bottom)
        horizontalStackView.addConstraint(to: contentView, on: .horizontal, with: .horizontalPadding)
        horizontalStackView.topAnchor.constraint(equalTo: videoPlayer.bottomAnchor, constant: .verticalPadding).isActive = true
        horizontalStackView.addArrangedSubview(verticalStackView)
    }
    
    private func setupTextViews() {
        verticalStackView.addArrangedSubview(titleLabel)
        titleLabel.text = viewModel.lesson.name
        verticalStackView.addArrangedSubview(descriptionLabel)
        descriptionLabel.text = viewModel.lesson.description
    }
    
    private func setupBarButtonItem() {
        let button: DownloadBarButton = .init {
            // did tap
        }
        navigationController?.navigationItem.rightBarButtonItem = button
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // To make self deinited 
        navigationController?.viewControllers = []
    }
}
