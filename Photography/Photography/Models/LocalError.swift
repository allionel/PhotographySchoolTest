//
//  LocalError.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/2/23.
//

import Foundation

enum LocalError: Int, Error {
    typealias RawValue = Int
    case accessDenied
    case unableToSave
    case unableToFetch
    case unknown
}
