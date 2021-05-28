//
//  GetInflationGovernorResult.swift
//  
//
//  Created by Nathan Lawrence on 5/27/21.
//

import Foundation

/**
 The current inflation governor.
 */
public struct GetInflationGovernorResult: Codable {
    /**
     Initial inflation percentage, from time 0.
     */
    let initial: Double

    /**
     Terminal inflation percentage.
     */
    let terminal: Double

    /**
     Per year rate for inflation lowering, rate reduction derived using target slot time in genesis config.
     */
    let taper: Double

    /**
     Percentage of total inflation allocated to the foundation.
     */
    let foundation: Double

    /**
     Duration of of foundation pool inflation, in years.
     */
    let foundationTerm: Double
}
