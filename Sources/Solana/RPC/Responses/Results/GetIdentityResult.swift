//
//  File.swift
//  
//
//  Created by Nathan Lawrence on 5/27/21.
//

import Foundation

/**
 Identity pubkey of the current node.
 */
public struct GetIdentityResult: Codable {
    /**
     The identity pubkey of the current node.
     */
    public let identity: Base58
}
