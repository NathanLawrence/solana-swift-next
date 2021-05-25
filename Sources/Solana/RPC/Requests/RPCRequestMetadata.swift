//
//  RPCRequestMetadata.swift
//  Solana
//
//  Created by Nathan Lawrence on 5/24/21.
//

import Foundation

public protocol RPCRequestMetadata: Encodable {
    
}

public struct NoRequestMetadata: RPCRequestMetadata {
    public func encode(to encoder: Encoder) throws {
        assertionFailure("`NoRequestMetadata` objects should not be encoded into a response.")
        return
    }
}
