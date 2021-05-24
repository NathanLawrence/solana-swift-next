//
//  RPCNode.swift
//  Solana
//
//  Created by Nathan Lawrence on 5/22/21.
//

import Foundation

public struct RPCNode {
    public init(url: URL) {
        self.url = url
    }

    let url: URL
}
