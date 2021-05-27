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
public protocol RPCRequest: Hashable {
    /**
     The kind of response this request should receive back from a node after being made.
     */
    associatedtype Response

    /**
     The single-field-encoded value that forms the first part of this request's `RPCRequestPayload`.
     */
    associatedtype Value: Codable

    /**
     The key-value paired information necessary to perform a given the request. This is encoded alongside the basic value to create an `RPCRequestPayload` that reflects the information necessary to perform the request.
     */
    associatedtype KeyedBody: RPCRequestKeyedBody

    /**
     The `RPCRequestPayload` generated and sent to the server as `values` in your final tagged request. This contains both the basic single-field value provided and any key-value paired body information.
     */
    var payload: RPCRequestPayload<Value, KeyedBody> { get }

    /**
     The single-field-encoded value that forms the first part of this request's `RPCRequestPayload`.
     */
    var value: Value { get }
}
