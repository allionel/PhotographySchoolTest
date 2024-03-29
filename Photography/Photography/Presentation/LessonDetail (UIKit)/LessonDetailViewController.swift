//
//  LessonDetailViewController.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/4/23.
//

import UIKit
import SwiftUI
import Combine

final class LessonDetailViewController: UIViewController {
    @ObservedObject private var viewModel: LessonDetailViewModel
    
    private let screenHeight: CGFloat = UIScreen.main.bounds.height
    private var cancellable: [AnyCancellable] = []
    
    private let appearingDelay: TimeInterval = 0.5
    private let arrowSpacerSize: CGFloat = 88
    
    // MARK: - UI Properties -
    
    private var downloadBarItem: DownloadBarItem = {
        let item: DownloadBarItem = .init(progressSize: 20)
        return item
    }()

    // We use scrollView because of supportin long text appearance if it comes from server
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
    
    private lazy var nextButtonsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    private lazy var nextLessonButton: LabelButton = {
        let button = LabelButton(direction: .right)
        button.title = .nextLesson.localized
        button.image = .chevronRight
        return button
    }()
    
    private lazy var previousLessonButton: LabelButton = {
        let button = LabelButton(direction: .left)
        button.title = .previousLesson.localized
        button.image = .chevronLeft
        return button
    }()
    
    // MARK: - Initialize
    weak var parentControllerDelegate: PageViewControllerProvider?
    
    init(parentControllerDelegate: PageViewControllerProvider, viewModel: LessonDetailViewModel) {
        self.parentControllerDelegate = parentControllerDelegate
        self._viewModel = .init(wrappedValue: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(String.initCoderFatalError)
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        
        // Navigation needs to be ready because of transition from swiftui view
        DispatchQueue.main.asyncAfter(deadline: .now() + appearingDelay) { [self] in
            setupUIElement()
            setupBarButtonItems()
            setupDownloadProgress()
            checkIfIsFirstPage()
            checkIfIsLastPage()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // To make self deinited
        if navigationController?.presentedViewController == nil {
            videoPlayer.terminateProcess()
        }
    }
    
    deinit {
        #if DEBUG
            debugPrint(String.deinitMessage)
        #endif
        viewModel.cancelDownloading()
    }
    
    // MARK: - Setup UI Elements -
    
    private func setupUIElement() {
        setupScrollView()
        setupVideoPlayer()
        setupStackView()
        setupTextViews()
        setupNextAndPreviousButton()
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
        videoPlayer.videoPath = viewModel.videoUrl
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
    
    private func setupBarButtonItems() {
        let items: UIBarButtonItem = .init(customView: downloadBarItem)
        setupDownloadActions()
        navigationController?.navigationItem.rightBarButtonItem = items
    }

    private func setupNextAndPreviousButton() {
        verticalStackView.addArrangedSubview(nextButtonsStack)
        nextButtonsStack.addArrangedSubview(previousLessonButton)
        nextButtonsStack.addArrangedSubview(UIView.spacer(size: arrowSpacerSize))
        nextButtonsStack.addArrangedSubview(nextLessonButton)
        setupNextAndPreviousActions()
    }

    // MARK: - Operations -
    
    private func setupDownloadProgress() {
        viewModel.$downloadProgress
            .receive(on: DispatchQueue.main)
            .assign(to: \.downloadProgress, on: downloadBarItem)
            .store(in: &cancellable)
    }
    
    private func setupDownloadActions() {
        downloadBarItem.didTapDownload { [weak self] in
            self?.viewModel.startDownloadingVideo()
        }
        viewModel.$downloadState
            .receive(on: DispatchQueue.main)
            .assign(to: \.viewState, on: downloadBarItem)
            .store(in: &cancellable)
    }
    
    private func setupNextAndPreviousActions() {
        nextLessonButton.addAction { [weak self] in
            guard let self, let delegate = self.parentControllerDelegate else { return }
            self.checkIfIsLastPage()
            delegate.gotoNextPage()
        }
        previousLessonButton.addAction { [weak self] in
            guard let self, let delegate = self.parentControllerDelegate else { return }
            self.checkIfIsFirstPage()
            delegate.gotoPreviousPage()
        }
    }
    
    private func checkIfIsFirstPage() {
        if parentControllerDelegate?.pageStatus.isFirstPage == true {
            self.previousLessonButton.alpha = 0
            self.nextLessonButton.alpha = 1
        }
    }
    
    private func checkIfIsLastPage() {
        if parentControllerDelegate?.pageStatus.isLastPage == true {
            self.previousLessonButton.alpha = 1
            self.nextLessonButton.alpha = 0
        }
    }
}
