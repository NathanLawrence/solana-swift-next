//
//  Base58.swift
//  Solana
//
//  Created by Nathan Lawrence on 5/24/21.
//

import Foundation

/**
 Data represented as a Base58-encoded string.
 */
public struct Base58: Codable {
    /**
     The underlying data the Base58 structure represents.
     */
    public var data: Data

    /**
     The underlying data the Base58 structure represents, in blocks of 8 bits.
     */
    public var dataBytes: [Byte] {
        Array<Byte>(data)
    }

    public init(_ data: Data) {
        self.data = data
    }

    private static let numerals = Array<Byte>(
        "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz"
            .utf8
    )
}
