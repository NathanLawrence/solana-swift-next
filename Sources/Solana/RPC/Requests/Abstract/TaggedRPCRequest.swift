//
//  TaggedRPCRequest.swift
//  
//
//  Created by Nathan Lawrence on 5/27/21.
//

import Foundation

/**
 The structure that wraps each JSON-RPC request made to a Solana node, providing it with necessary information about how the request should be performed and identified in responses.

 You can provide this wrapper manually with your request, allowing you to specify information like the version of the JSON-RPC spec and the Integer ID the node will use in communication about this request, or you can allow your `RPCSession` to do this for you.

 ### Letting RPCSession do the work - most common
 ```swift
 let session = RPCSession(...)
 let request = RandomInformationRequest(...)

 // You will not have knowledge of the JSON-RPC Spec
 // or the identifier sent to the node, but
 // because of the framework's structure, you usually
 // don't need either of these.
 let publisher = session.publish(request)
 ```

 ### Manually building the tagged request
 ```swift
 let session = RPCSession(...)
 let request = RandomInformationRequest(...)

 // You can keep track of this ID and throw all your requests
 // and responses around however you want this way.
 let taggedRequest = TaggedRPCRequest(request, id: 123456)
 let publisher = session.publish(wrappedRequest)
 ```

 */
public struct TaggedRPCRequest<Request: RPCRequest>: Encodable {
    public init(_ request: Request,
                id: Int = UUID().hashValue) {
        self.id = id
        self.request = request
    }

    /**
     The version of the JSON-RPC spec.
     */
    let rpcSpecficationVersion: String = "2.0"

    /**
     The request identifier shared with the server.
     */
    var id: Int = 1

    /**
     The request that will be sent to the server.
     */
    let request: Request

    public func encode(to encoder: Encoder) throws {
        var fieldset = encoder.container(keyedBy: String.self)
        try fieldset.encode(rpcSpecficationVersion, forKey: "jsonrpc")
        try fieldset.encode(Request.methodName, forKey: "method")

        if !(Request.Value.self == NoRPCRequestValue.self &&
             Request.KeyedBody.self == NoKeyedBody.self) {
            try fieldset.encode(request.payload, forKey: "params")
        }

        try fieldset.encode(id, forKey: "id")
    }
}


extension String: CodingKey {
    public init?(intValue: Int) {
        nil
    }

    public init?(stringValue: String) {
        self.init(stringValue)
    }

    public var stringValue: String {
        self
    }

    public var intValue: Int? {
        nil
    }
}
