//
//  File.swift
//  
//
//  Created by Nathan Lawrence on 6/12/21.
//

import Foundation
import Combine

public class RPCNetworkRequestAdaptor: RPCRequestAdaptor {
    internal init(task: URLSessionDataTask? = nil, nodeURL: URL) {
        self.task = task
        self.nodeURL = nodeURL
    }

    var task: URLSessionDataTask?

    public func publisher<Request>(for request: TaggedRPCRequest<Request>) -> AnyPublisher<TaggedRPCResponse<Request.Response, SolanaNodeError>, Error>
        where Request: RPCRequest {
        Just(request)
            .encode(encoder: RPC.requestEncoder)
            .mapError { RPCNetworkRequestError.requestEncodingError($0) }
            .map { requestBody -> URLRequest in
                var request = URLRequest(url: self.nodeURL)
                request.httpMethod = "POST"
                request.httpBody = requestBody
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                return request
            }
            .print("requestmaker")
            .flatMap { request in
                return self.urlSession.dataTaskPublisher(for: request)
                    .print("datataskpub")
                    .mapError { RPCNetworkRequestError.networkFetchError($0) }
            }
            .print("flatmap")
            .map {
                $0.data
            }
            .flatMap { data in
                Just(data)
                    .decode(type: TaggedRPCResponse<Request.Response, SolanaNodeError>.self,
                            decoder: RPC.responseDecoder)
                    .mapError { RPCNetworkRequestError.responseDecodingError($0) }
            }
            .eraseToAnyPublisher()
    }
    
    public func webSocketPublisher<Request: WebSocketRequest>(for taggedRequest: TaggedRPCRequest<Request>)
    -> AnyPublisher<URLSessionWebSocketTask.Message, WebSocketError> {
        Just(taggedRequest)
            .tryMap { try $0.urlRequest(for: nodeURL) }
            .mapError { WebSocketError.requestConstructionError($0) }
            .flatMap { [unowned self] urlRequest in
                self.urlSession.webSocketPublisher(for: urlRequest)
            }
            .eraseToAnyPublisher()
    }

    let nodeURL: URL
    let urlSession = URLSession(configuration: .default)
}

public enum RPCNetworkRequestError: Error {
    case requestEncodingError(Error)
    case networkFetchError(Error)
    case responseDecodingError(Error)
}
