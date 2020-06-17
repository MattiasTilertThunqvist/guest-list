//
//  NetworkError.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-04-20.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case noDocument
    case failedEncoding
}

extension NetworkError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .noDocument:
            return "Couldn't load document"
        case .failedEncoding:
            return "Couldn't encode object"
        }
    }
}
