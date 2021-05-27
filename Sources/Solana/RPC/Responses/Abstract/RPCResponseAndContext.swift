//
//  RPCResponse.swift
//  Solana
//
//  Created by Nathan Lawrence on 5/22/21.
//

import Foundation

/**
 A result body that consists of the context (slot information) and actual value result of a given operation.

 Commonly returned from calls that query bank state.
 */
public struct RPCResponseAndContext<Response: RPCResponse>: Codable {
    /**
     The contextual information corresponding to this RPC response
     */
    public let context: RPCResponseContext

    /**
     The actual result of the operation.
     */
    public let value: Response
}

/**
 The contextual information corresponding to a given RPC response.
 */
public struct RPCResponseContext: Codable {
    /**
     The slot at which the operation was evaluated.
     */
    public let slot: UInt64
}
