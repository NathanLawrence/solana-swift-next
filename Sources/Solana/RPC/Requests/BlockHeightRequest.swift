//
//  BlockHeightRequest.swift
//  
//
//  Created by Nathan Lawrence on 6/12/21.
//

import Foundation

public struct BlockHeightRequest: RPCRequest {
    public init() {}

    public var payload: RPCRequestPayload<NoRPCRequestValue, NoKeyedBody> {
        RPCRequestPayload(value: .init(), requestMetadata: .init())
    }

    public static var methodName: String {
        "getBlockHeight"
    }

    public typealias Response = Int64
    public typealias Value = NoRPCRequestValue
    public typealias KeyedBody = NoKeyedBody
}
