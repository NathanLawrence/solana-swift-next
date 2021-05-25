//
//  RPCRequest.swift
//  Solana
//
//  Created by Nathan Lawrence on 5/22/21.
//

import Foundation

/**
 The protocol Solana JSON-RPC requests must confrom to.
 */
public protocol RPCRequestable: Hashable {
    associatedtype Response
    associatedtype Metadata: RPCRequestMetadata
    associatedtype Value: Codable

    var payload: RPCRequestPayload<Value, Metadata> { get }

    var value: Value { get }
}

public struct RPCRequest<Request: RPCRequestable>: Encodable {

    /**
     The version of the JSON-RPC spec.
     */
    let rpcSpecficationVersion: String = "2.0"

    /**
     The request identifier shared with the server.
     */
    var id: Int = UUID().hashValue

    /**
     The request that will be sent to the server.
     */
    let request: Request

    public func encode(to encoder: Encoder) throws {
        var fieldset = encoder.container(keyedBy: String.self)
        try fieldset.encode(rpcSpecficationVersion, forKey: "jsonrpc")
        try fieldset.encode(request.payload, forKey: "value")
        try fieldset.encode(id, forKey: "id")
    }
}


extension String: CodingKey {
    public init?(intValue: Int) {
        nil
    }

    public init?(stringValue: String) {
        self.init(stringValue)
    }

    public var stringValue: String {
        self
    }

    public var intValue: Int? {
        nil
    }
}
