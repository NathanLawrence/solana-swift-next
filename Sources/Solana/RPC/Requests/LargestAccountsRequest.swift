//
//  LargestAccountsRequest.swift
//  
//
//  Created by Nathan Lawrence on 6/13/21.
//

import Foundation

public struct LargestAccountsRequest: RPCRequest {
    public static var methodName: String = "getLargestAccounts"

    public typealias Response = RPCResponseAndContext<GetLargestAccountsResult>
    public typealias Value = NoRPCRequestValue
    public typealias KeyedBody = NoKeyedBody
}
