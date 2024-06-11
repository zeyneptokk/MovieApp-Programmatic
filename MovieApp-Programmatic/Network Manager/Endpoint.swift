//
//  Endpoint.swift
//  MovieApp-Programmatic
//
//  Created by zeynep on 29.03.2024.
//

import Foundation

public protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var apikey: String { get }
    var param: String { get }
    var method: String { get }
}

public extension Endpoint {
    var url: String { "\(baseURL)/\(path)?api_key=\(apikey)&\(param)" }
}
