//
//  NetworkRouter.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/2/23.
//

import Foundation
import Alamofire

enum RequestMethod: String {
    case get, post, put, patch, delete
}

protocol NetworkRouter: URLRequestConvertible {
    var baseURLString: String? { get }
    var method: RequestMethod? { get }
    var path: String { get }
    var headers: [String: String]? { get }
    var params: [String: Any]? { get }
    func asURLRequest() throws -> URLRequest
}

extension NetworkRouter {
    var baseURLString: String? {
        return "https://iphonephotographyschool.com/test-api/"
    }

    // Add Rout method here
    var method: RequestMethod? {
        return .get
    }

    // Set APIs'Rout for each case
    var path: String {
        return ""
    }

    // Set header here
    var headers: [String: String]? {
        return [:]
    }

    // Set encoding for each APIs
    var encoding: ParameterEncoding? {
        return JSONEncoding.default
    }

    // Return each case parameters
    var params: [String: Any]? {
        return [:]
    }

    // MARK: URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: baseURLString!.appending(path))
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = method?.rawValue.uppercased()
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        if method == .get {
            do {
                urlRequest = try URLEncoding.queryString.encode(urlRequest, with: params)
            } catch {
                print(error)
            }
        } else {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params ?? [:], options: .prettyPrinted)
        }
        return urlRequest
    }
}
