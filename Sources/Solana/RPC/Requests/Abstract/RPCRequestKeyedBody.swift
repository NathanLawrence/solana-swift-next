//
//  RPCRequestMetadata.swift
//  Solana
//
//  Created by Nathan Lawrence on 5/24/21.
//

import Foundation

/**
 The key-value paired information necessary to perform a given JSON-RPC request. This is encoded alongside the basic value to create an `RPCRequestPayload` that reflects the information necessary to perform the request.
 */
public protocol RPCRequestKeyedBody: Encodable { }

/**
 A structure to use to indicate that there is no key-value paired information that should accompany a JSON-RPC request.
 */
public struct NoKeyedBody: RPCRequestKeyedBody {
    init() {}
    public func encode(to encoder: Encoder) throws {
        assertionFailure("`NoRequestMetadata` objects should not be encoded into a response.")
        return
    }
}
