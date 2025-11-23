//
//  NetworkError.swift
//  API Example
//
//  Created by user285344 on 11/14/25.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case invalidRequest
    case badResponse //Any reponse that is not a HTTP-URL-RESPONSE
    case badStatus //Any status out side 200 range [200-299] --> [400-499] Unauthorised or not found or bad request
    case failedToDecodeResponse //Failed to decode data from JSON to Post Model
}

