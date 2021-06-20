//
//  PublicKey.swift
//  
//
//  Created by Nathan Lawrence on 6/2/21.
//

import Foundation

/**
 A length-enforced public key value represented in base 58.
 */
@dynamicMemberLookup
public struct PublicKey: Codable {

    public let base58: Base58

    /**
     Build a public key from a base-58 string.
     */
    public init(base58String text: String) throws {
        guard let attemptedBase58 = Base58(string: text) else {
            throw Base58Error.invalidRepresentation
        }

        try self.init(base58: attemptedBase58)
    }

    /**
     Build a public key from a base-58 object, checking length.
     */
    public init(base58: Base58) throws {
        // Public key length check.
        guard base58.dataBytes.count <= 32 else {
            throw Base58Error.invalidLength
        }

        self.base58 = base58
    }

    subscript<U>(dynamicMember keyPath: KeyPath<Base58, U>) ->
    U {
        self.base58[keyPath: keyPath]
    }

    public func encode(to encoder: Encoder) throws {
        try base58.encode(to: encoder)
    }

    public init(from decoder: Decoder) throws {
        let b58 = try Base58(from: decoder)
        try self.init(base58: b58)
    }
}
