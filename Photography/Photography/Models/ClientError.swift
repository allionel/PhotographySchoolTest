//
//  ClientError.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/2/23.
//

import Foundation

enum ClientError: Error {
    case localError(LocalError)
    case serverError(ServerError)
}
