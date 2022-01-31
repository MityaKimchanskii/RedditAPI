//
//  PostError.swift
//  RedditAPI
//
//  Created by Mitya Kim on 1/31/22.
//

import Foundation

enum PostError: LocalizedError {
    
    case invalidURL
    case throwError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
            
        case .invalidURL:
            return "The Server failed to reach the necessary URL."
        case .throwError(let error):
            return "Error: \(error.localizedDescription) -- \(error)"
        case .noData:
            return "The server responded with no data."
        case .unableToDecode:
            return "Unable to decode the data."
        }
    }
}
