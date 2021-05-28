//
//  Commitment.swift
//  
//
//  Created by Nathan Lawrence on 5/27/21.
//

import Foundation

/**
 The level of commitment desired when querying state.
 */
public enum Commitment: String, RawRepresentable, Codable {
    /**
     Query the most recent block which has reached 1 confirmation by the connected node.
     */
    case processed

    /**
     Query the most recent block which has reached 1 confirmation by the cluster.
     */
    case confirmed
    
    /**
     Query the most recent block which has been finalized by the cluster.
     */
    case finalized
}
