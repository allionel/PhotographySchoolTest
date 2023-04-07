//
//  Strings+Extension.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/2/23.
//

import Foundation

public extension String {
    var localized: String {
        return NSLocalizedString(self, bundle: .main, comment: "")
    }
}
