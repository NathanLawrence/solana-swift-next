//
//  RPCRequestAdaptor.swift
//  Solana
//
//  Created by Nathan Lawrence on 5/22/21.
//

import Foundation

/**
 A protocol that represents the bridging logic betweeen a source of knowledge and a session that handles Solana JSON-RPC requests.

 Conform to this protocol and set up an `RPCSession` object with your conforming object to create a custom testing or mock system. For normal use, `RPCNetworkRequestAdaptor` comes pre-configured, and `RPCPassthroughRequestAdaptor` can handle sending flat files from disk.
 */
public protocol RPCRequestAdaptor {
    func request<Request: RPCRequest>(_ request: Request) async throws -> RPCResponse<Request.Response>
}
