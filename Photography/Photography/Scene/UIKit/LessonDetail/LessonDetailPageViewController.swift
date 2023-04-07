//
//  LessonDetailPageViewController.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/7/23.
//

import UIKit

protocol PageViewControllerProvider: AnyObject {
    func gotoNextPage()
    func gotoPreviousPage()
}

final class LessonDetailPageViewController: UIViewController {
    let currentLesson: Lesson
    let lessons: [Lesson]
    
    // MARK: - UI Properties -
    
    private lazy var pageViewController: PageViewController = {
        let pageViewController: PageViewController = .init()
        pageViewController.isScrollEnabled = false
        return pageViewController
    }()
    
    // MARK: - Initialize
    
    init(currentLesson: Lesson, lessons: [Lesson]) {
        self.currentLesson = currentLesson
        self.lessons = lessons
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(String.initCoderFatalError)
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        setupPageViewController()
        setupViewControllers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    // MARK: - Setup
    
    private func setupPageViewController() {
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pageViewController.view.fill(to: view)
        didMove(toParent: self)
    }
    
    private func setupViewControllers() {
        guard let pageIndex = lessons.firstIndex(where: { $0 == currentLesson}) else { return }
        let viewController = LessonDetailViewController(parentControllerDelegate: self, viewModel: .init(lesson: currentLesson))
        pageViewController.pages = [viewController]
        pageViewController.page = .next(index: pageIndex)
    }
}

extension LessonDetailPageViewController: PageViewControllerProvider {
    func gotoNextPage() {
        let nextIndex = pageViewController.page.pageIndex + 1
        let viewController = LessonDetailViewController(parentControllerDelegate: self, viewModel: .init(lesson: lessons[nextIndex]))
        pageViewController.pages = [viewController]
        pageViewController.page = .next(index: nextIndex)
    }
    
    func gotoPreviousPage() {
        let previousIndex = pageViewController.page.pageIndex - 1
        let viewController = LessonDetailViewController(parentControllerDelegate: self, viewModel: .init(lesson: lessons[previousIndex]))
        pageViewController.pages = [viewController]
        pageViewController.page = .previous(index: previousIndex)
    }
}
