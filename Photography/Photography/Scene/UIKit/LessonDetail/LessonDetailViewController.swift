//
//  LessonDetailViewController.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/4/23.
//

import UIKit
import SwiftUI

final class LessonDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupBarButtonItem()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        setupBarButtonItem()
//    }
    
    private func setupBarButtonItem() {
        let button: DownloadBarButton = .init {
            // did tap
        }
        navigationController?.navigationItem.rightBarButtonItem = button
    }
}





