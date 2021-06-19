//
//  RPCRequestAdaptor.swift
//  Solana
//
//  Created by Nathan Lawrence on 5/22/21.
//

import Foundation
import Combine

/**
 A protocol that represents the bridging logic betweeen a source of knowledge and a session that handles Solana JSON-RPC requests.

 Conform to this protocol and set up an `RPCSession` object with your conforming object to create a custom testing or mock system. For normal use, `RPCNetworkRequestAdaptor` comes pre-configured, and `RPCPassthroughRequestAdaptor` can handle sending flat files from disk.
 */
public protocol RPCRequestAdaptor {
    /**
     Creates an automatically-connecting Combine publisher that responds to a given request. Since the request has not already been wrapped with `TaggedRPCRequest`, this will create an identifier and its tags internally.
     */
    func publisher<Request: RPCRequest>(
        for unwrappedRequest: Request
    ) -> AnyPublisher<TaggedRPCResponse<
        Request.Response,
        SolanaNodeError>, Error>

    /**
     Creates an automatically-connecting Combine publisher that responds to a given request.
     */
    func publisher<Request: RPCRequest>(
        for request: TaggedRPCRequest<Request>
    ) -> AnyPublisher<TaggedRPCResponse<
        Request.Response,
        SolanaNodeError>, Error>

    /**
     Creates an automatically-connecting Combine publisher that emits signals from a web socket task created for a given request. Since the request has not already been wrapped with `TaggedRPCRequest`, this will create an identifier and its tags internally.
     */
    func webSocketPublisher<Request: WebSocketRequest>(for untaggedRequest: Request)
    -> AnyPublisher<URLSessionWebSocketTask.Message, WebSocketError>

    /**
     Creates an automatically-connecting Combine publisher that emits signals from a web socket task created for a given request.
     */
    func webSocketPublisher<Request: WebSocketRequest>(for taggedRequest: TaggedRPCRequest<Request>)
    -> AnyPublisher<URLSessionWebSocketTask.Message, WebSocketError>
}

extension RPCRequestAdaptor {
    public func publisher<Request: RPCRequest>(for unwrappedRequest: Request)
        -> AnyPublisher<TaggedRPCResponse<
            Request.Response,
            SolanaNodeError>, Error> {
        let wrapped = TaggedRPCRequest(unwrappedRequest)
        return publisher(for: wrapped)
    }

    public func webSocketPublisher<Request: WebSocketRequest>(for untaggedRequest: Request)
    -> AnyPublisher<URLSessionWebSocketTask.Message, WebSocketError> {
        let taggedRequest = TaggedRPCRequest(untaggedRequest)
        return self.webSocketPublisher(for: taggedRequest)
    }
}
