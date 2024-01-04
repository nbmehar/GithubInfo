//
//  APIError.swift
//  play
//
//  Created by Nayab Mehar on 03/01/24.
//

import Foundation

enum APIError: Error {
    static let commonErrorDescription = "Something went wrong. Please try again later."

    case cancelled
    case invalidURL
    case noResponse
    case unknown(Error?)

    case jsonDecodingError(error: Error, data: Data? = nil)
    case networkError(error: Error)
    case jsonEncodeError(error: Error, data: Encodable)

    case serverError(code: Int, response: ErrorResponse)
}
