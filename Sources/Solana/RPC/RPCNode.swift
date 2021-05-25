//
//  RPCNode.swift
//  Solana
//
//  Created by Nathan Lawrence on 5/22/21.
//

import Foundation

/**
 A node on the Solana network, addressable via JSON-RPC calls.
 */
public struct RPCNode {
    public init(url: URL) {
        self.url = url
    }

    public let url: URL
}
