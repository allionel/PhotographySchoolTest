//
//  PageViewState.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/7/23.
//

import Foundation
import class UIKit.UIPageViewController

enum PageViewState {
    case next(index: Int)
    case previous(index: Int)
}

extension PageViewState {
    var pageIndex: Int {
        switch self {
        case .next(let index):
            return index
        case .previous(let index):
            return index
        }
    }
    
    var direction: UIPageViewController.NavigationDirection {
        switch self {
        case .next:
            return .forward
        case .previous:
            return .reverse
        }
    }
}
