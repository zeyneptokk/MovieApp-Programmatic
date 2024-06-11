//
//  ApiClientError.swift
//  MovieApp-Programmatic
//
//  Created by zeynep on 29.03.2024.
//

import Foundation

public protocol APIError: Decodable {
    var statusCode: Int? { get }
    var statusMessage: String? { get }
    var success: Bool? { get }
}

struct ClientError: APIError {
    var statusCode: Int?
    var statusMessage: String?
    var success: Bool?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case success
    }
}

public enum APIClientError: Error {
    case handledError(error: APIError)
    case networkError
    case decoding(error: DecodingError?)
    case timeout
    case message(String)
    
    public var statusMessage: String {
        switch self {
        case .handledError(let error):
            return error.statusMessage ?? ""
        case .decoding:
            return "Decoding Hatası oluştu."
        case .networkError:
            return "Network Hatası oluştu."
        case .timeout:
            return "İstek zaman aşımına uğradı."
        case .message(let message):
            return message
        }
    }
    public var title: String {
        switch self {
        case .handledError, .decoding, .networkError, .timeout, .message:
            return "Error"
        }
    }
    
    public var statusCode: Int {
        switch self {
        case .handledError(let error):
            return error.statusCode ?? 0
        default:
            return 500
        }
    }
}
