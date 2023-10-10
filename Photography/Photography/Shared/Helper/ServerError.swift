//
//  ServerError.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/2/23.
//

import Foundation

public enum ServerError: Int, Error {
    public typealias RawValue = Int
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case tooManyRequests = 429
    case internalServer = 500
    case badGateway = 502
    case timeOut = 504
    case invalidRequest = 509
    case unreachable = 1000
    case unknown = 1002
}

extension ServerError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .badRequest:
            return "Invalid Request Parameters"
        case .unauthorized:
            return "Unauthorized Access"
        case .forbidden:
            return "Forbidden Access"
        case .notFound:
            return "Not found"
        case .tooManyRequests:
            return "Too many requests"
        case .internalServer:
            fallthrough
        case .badGateway:
            return "Bad gateway"
        case .timeOut:
            return "error_server_unreachable_message"
        case .invalidRequest:
            return "Invalid Request parameters"
        case .unreachable:
            return "error_network_unreachable_message"
        case .unknown:
            return "Unknown error."
        }
    }
}
