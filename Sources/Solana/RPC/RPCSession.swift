//
//  RPCSession.swift
//  Solana
//
//  Created by Nathan Lawrence on 5/22/21.
//

import Foundation

public class RPCSession {
    public init(url: URL) {
        self.requestAdaptor = RPCNetworkRequestAdaptor(nodeURL: url)
    }

    public let requestAdaptor: RPCRequestAdaptor

}
