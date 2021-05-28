//
//  GetInflationRewardResult.swift
//  
//
//  Created by Nathan Lawrence on 5/27/21.
//

import Foundation

/**
 The inflation reward for a list of addresses for an epoch.
 */
public struct GetInflationRewardResult: Codable {
    /**
     Epoch during which reward occurred.
     */
    public let epoch: UInt64

    /**
     The slot in which the rewards are effective.
     */
    public let effectiveSlot: UInt64

    /**
     The reward amount, in lamports.
     */
    public let amount: UInt64

    /**
     The post balance in lamports.
     */
    public let postBalance: UInt64
}
