//
//  RPCResponse.swift
//  Solana
//
//  Created by Nathan Lawrence on 5/22/21.
//

import Foundation

@dynamicMemberLookup
public struct RPCResponse<Result: RPCResponseContent>: Codable {

    /**
     The result of the RPC call.
     */
    let result: Result

    /**
     The request identifier shared with the server.
     */
    let id: Int

    /**
     The version of the JSON-RPC spec.
     */
    let rpcSpecficationVersion: String

    subscript<T>(dynamicMember dynamicMember: KeyPath<Result, T>) -> T {
        return result[keyPath: dynamicMember]
    }

    enum CodingKeys: String, CodingKey {
        case result
        case id

        case rpcSpecficationVersion = "jsonrpc"
    }
}
