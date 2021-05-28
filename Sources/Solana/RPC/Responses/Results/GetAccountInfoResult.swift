//
//  GetAccountInfoResult.swift
//  
//
//  Created by Nathan Lawrence on 5/27/21.
//

import Foundation

public typealias GetAccountInfoResult = AccountInfo?

/**
 Information associated with a given account.
 */
public struct AccountInfo: Codable {
    /**
     Number of lamports assigned to this account.
     */
    public let lamports: UInt64

    /**
     Pubkey of the program this account has been assigned to.
     */
    public let owner: Base58

    /**
     Data associated with the account, may be binary blobs or JSON that must be decoded separately.
     */
    public let data: [String: Data]

    /**
     Indicates if the account owns a program.
     */
    public let executable: Bool

    /**
     The epoch at which this account will next owe rent.
     */
    public let rentEpoch: UInt64
}
