//
//  RPC.swift
//  Solana
//
//  Created by Nathan Lawrence on 5/22/21.
//

import Foundation

/**
 The namespace for general utilities related to Solana JSON-RPC tasks.
 */
public enum RPC {

    static let requestEncoder: JSONEncoder = {
        let coder = JSONEncoder()
        coder.dateEncodingStrategy = Self.dateEncodingStrategy
        return coder
    }()

    static let responseDecoder: JSONDecoder = {
        let coder = JSONDecoder()
        coder.dateDecodingStrategy = Self.dateDecodingStrategy
        return coder
    }()

    /**
     Solana nodes pass time as seconds since the POSIX epoch. For more information, see: https://docs.solana.com/developing/clients/jsonrpc-api
     */
    static let dateEncodingStrategy = JSONEncoder.DateEncodingStrategy.secondsSince1970

    /**
     Solana nodes pass time as seconds since the POSIX epoch. For more information, see: https://docs.solana.com/developing/clients/jsonrpc-api
     */
    static let dateDecodingStrategy = JSONDecoder.DateDecodingStrategy.secondsSince1970

}
