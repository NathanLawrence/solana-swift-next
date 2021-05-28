//
//  TaggedRPCResponse.swift
//  
//
//  Created by Nathan Lawrence on 5/27/21.
//

import Foundation

/**
 A JSON-RPC response, indicating either success or failure, wrapped in an identifier and specification version.
 */
public struct TaggedRPCResponse<Success: Codable, Failure: Error> {
    /**
     The result of the RPC call, if it succeeded.
     */
    public let result: Success?

    /**
     An error associated with the RPC call, if it failed.
     */
    public let error: Failure?

    /**
     The request identifier shared with the server.
     */
    public let id: Int

    /**
     The version of the JSON-RPC spec.
     */
    public let rpcSpecificationVersion: String

    /**
     A `Result` typed object that shows either success or failure of the RPC call.
     */
    public var outcome: Result<Success, Failure> {
        if let result = result {
            return .success(result)
        } else if let error = error {
            return .failure(error)
        } else {
            fatalError("Result returned neither success nor failure, indicating outside-spec server response.")
        }
    }

    enum CodingKeys: String, CodingKey {
        case result
        case error
        case id

        case rpcSpecificationVersion = "jsonrpc"
    }
}
