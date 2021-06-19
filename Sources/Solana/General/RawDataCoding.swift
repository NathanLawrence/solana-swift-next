//
//  RawDataCoding.swift
//  
//
//  Created by Nathan Lawrence on 6/19/21.
//

import Foundation

/**
 A protocol that indicates a data structure can be rendered as raw `Data`.
 */
public protocol RawDataEncoding {
    func rawData() -> Data
}

/**
 A protocol that indicates a data structure can be rebuilt from only `Data`.
 */
public protocol RawDataDecoding {
    init(rawData: Data) throws
}

/**
 A protocol that inbdicates a data structure can be both rendered and rebuilt as `Data`.
 */
public protocol RawDataCoding: RawDataEncoding, RawDataDecoding { }

/**
 The error a Solana SDK object throws when RawDataCoding fails.
 */
public struct RawDataCodingError {
    public init(message: String, underlyingError: Error?) {
        self.message = message
        self.underlyingError = underlyingError
    }

    let message: String
    let underlyingError: Error?

    enum Category {
        case decodingError
    }
}
