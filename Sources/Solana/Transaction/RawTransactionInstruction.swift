//
//  RawTransactionInstruction.swift
//  
//
//  Created by Nathan Lawrence on 6/20/21.
//

import Foundation

/**
 A `TransactionInstruction` implementor that allows the consumer to build instructions ad-hoc within a transaction body without creating custom types.
 */
public struct RawTransactionInstruction: TransactionInstruction {
    public init(programId: PublicKey, keys: [TransactionKey], data: Data?) {
        self.keys = keys
        self.programId = programId
        self.data = data
    }

    public let keys: [TransactionKey]
    public let programId: PublicKey
    public let data: Data?
}
