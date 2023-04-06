//
//  DownloadState.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/6/23.
//

import Foundation

enum DownloadState {
    case ready
    case downloading
    case done
    
    var visible: (ready: Bool, downloading: Bool, done: Bool) {
        switch self {
        case .ready:
            return (true, false, false)
        case .downloading:
            return (false, true, false)
        case .done:
            return (false, false, true)
        }
    }
}
