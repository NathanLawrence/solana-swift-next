//
//  RPCRequestPayload.swift
//  Solana
//
//  Created by Nathan Lawrence on 5/24/21.
//

import Foundation

public struct RPCRequestPayload<Value: Encodable, RequestMetadata: RPCRequestMetadata>: Encodable {
    let value: Value
    let requestMetadata: RequestMetadata

    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(value)

        // Only encode request metadata if the request has some.
        if !(requestMetadata is NoRequestMetadata) {
            try container.encode(requestMetadata)
        }

        return
    }
}
