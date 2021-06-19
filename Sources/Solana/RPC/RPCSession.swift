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


    /**
     When Transaction Safe Mode is enabled, the framework will attempt to validate transactions before they are submitted to the chain. If a transaction is potentially dangerous or has inconsistent signatures, the framework will trigger a precondition failure, abort the action, and allow you to investigate the error.

     By default, Transaction Safe Mode is enabled when your app is built in a debug setting and disabled in production.
     */
    public var transactionSafeModeEnabled: Bool = {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }()
}
