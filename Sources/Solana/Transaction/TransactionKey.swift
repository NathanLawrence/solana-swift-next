//
//  TransactionKey.swift
//  
//
//  Created by Nathan Lawrence on 6/14/21.
//

import Foundation

/**
 A key used to authorize a transaction or instruction.
 */
public struct TransactionKey: Hashable, Equatable {
    internal init(publicKey: Base58, isSigner: Bool, isWritable: Bool) {
        self.publicKey = publicKey
        self.isSigner = isSigner
        self.isWritable = isWritable
    }

    let publicKey: Base58
    let isSigner: Bool
    let isWritable: Bool
}
