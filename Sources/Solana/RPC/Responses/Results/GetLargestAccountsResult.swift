//
//  GetLargestAccountsResult.swift
//  
//
//  Created by Nathan Lawrence on 5/27/21.
//

import Foundation

/**
 An address and the number of lamports in the account.
 */
public struct LamportBalanceStatement: Codable {
    /**
     Base-58 encoded address of the account.
     */
    public let address: Base58

    /**
     Number of lamports in the account.
     */
    public let lamports: UInt64
}

public typealias GetLargestAccountsResult = [LamportBalanceStatement]
