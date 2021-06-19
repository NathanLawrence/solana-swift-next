//
//  RPCSession.swift
//  Solana
//
//  Created by Nathan Lawrence on 5/22/21.
//

import Foundation
import Combine

/**
 A session that handles communication with the Solana JSON-RPC API.
 */
public class RPCSession {
    /**
     Start a networked JSON-RPC session with a given node's URL.
     */
    public init(url: URL) {
        self.requestAdaptor = RPCNetworkRequestAdaptor(nodeURL: url)
    }

    /**
     Start a JSON-RPC session with a custom `RPCRequestAdaptor` conforming object. Use this initializer to build a custom debugging or testing pipeline.
     */
    public init(adaptor: RPCRequestAdaptor) {
        self.requestAdaptor = adaptor
    }

    /**
     The active RPC Request Adapter used on this RPC Session. An `RPCRequestAdaptor` determines how RPC responses are sent through the Solana SDK. To build a custom debugging or testing pipeline, you can provide your own `RPCRequestAdaptor` conforming object.
     */
    public let requestAdaptor: RPCRequestAdaptor

    func publish<Request: RPCRequest>(_ unwrappedRequest: Request)
        -> AnyPublisher<TaggedRPCResponse<Request.Response, SolanaNodeError>, Error> {
        return requestAdaptor.publish(unwrappedRequest)
    }

    func publish<Request: RPCRequest>(_ request: TaggedRPCRequest<Request>)
        -> AnyPublisher<TaggedRPCResponse<Request.Response, SolanaNodeError>, Error> {
        return requestAdaptor.publish(request)
    }

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
