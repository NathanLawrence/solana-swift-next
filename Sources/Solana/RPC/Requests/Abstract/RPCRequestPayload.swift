//
//  RPCRequestPayload.swift
//  Solana
//
//  Created by Nathan Lawrence on 5/24/21.
//

import Foundation


public struct RPCRequestPayload<Value: Encodable, RequestMetadata: RPCRequestKeyedBody>: Encodable {
    let value: Value
    let requestMetadata: RequestMetadata

    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(value)

        // Only encode request metadata if the request has some.
        if !(requestMetadata is NoKeyedBody) {
            try container.encode(requestMetadata)
        }

        return
    }
}

public struct NoRPCRequestValue: Codable {
    init() {}

    public func encode(to encoder: Encoder) throws {
        assertionFailure("`NoRPCRequestValue` objects should not be encoded into a request.")
        return
    }
}
