//
//  RPCRequest.swift
//  Solana
//
//  Created by Nathan Lawrence on 5/22/21.
//

import Foundation

public protocol RPCRequest: Hashable {
    associatedtype Response
}

struct RPCRequestPayload<RequestMetadata: Codable, Value: Codable>: Encodable {
    let value: Value

    let requestMetadata: RequestMetadata

    func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(value)
        try container.encode(requestMetadata)
    }
}
