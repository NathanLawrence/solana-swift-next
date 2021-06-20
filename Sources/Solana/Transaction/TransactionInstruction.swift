//
//  File.swift
//  
//
//  Created by Nathan Lawrence on 6/14/21.
//

import Foundation

/**
 An instruction to be delivered as part of a sequenced list for use in a Transaction. Conform to this protocol to deliver a custom instruction.

 To build an instruction directly as part of a transaction, use `RawTransactionInstruction`.
 */
public protocol TransactionInstruction: CompilableInstructionSet {
    var keys: [TransactionKey]  { get }
    var programId: PublicKey { get }
    var data: Data? { get }
}
