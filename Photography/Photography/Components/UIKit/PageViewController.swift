//
//  PageViewController.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/7/23.
//

import UIKit

final class PageViewController: UIPageViewController {
    var pages: [UIViewController] = []
    var page: PageViewState = .next(index: .zero) {
        didSet {
            setViewControllers([pages[.zero]], direction: page.direction, animated: true, completion: nil)
        }
    }
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        dataSource = self
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= .zero else { return pages.last }
        guard pages.count > previousIndex else { return nil }
        return pages[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < pages.count else { return pages.first }
        guard pages.count > nextIndex else { return nil }
        return pages[nextIndex]
    }
}

extension UIPageViewController {
    var isScrollEnabled: Bool {
        set {
            let scrollView = (self.view.subviews.first(where: { $0 is UIScrollView }) as? UIScrollView)
            scrollView?.isScrollEnabled = newValue
            scrollView?.canCancelContentTouches = newValue
        }
        get {
            return (self.view.subviews.first(where: { $0 is UIScrollView }) as? UIScrollView)?.isScrollEnabled ?? true
        }
    }
}
