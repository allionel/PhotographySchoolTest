//
//  LocalError.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/2/23.
//

import Foundation

public enum LocalError: Int, Error {
    public typealias RawValue = Int
    case accessDenied
    case unableToSave
    case unableToFetch
    case unknown
}
