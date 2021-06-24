//
//  RPCSession+TransactionSafeMode.swift
//  
//
//  Created by Nathan Lawrence on 6/20/21.
//

import Foundation

extension RPCSession {
    func validateOrCrashInSafeMode<T: Transaction>(on transaction: T) {

        // If we're not in safe mode, we don't validate.
        guard transactionSafeModeEnabled else {
            return
        }

        precondition(transaction.validate(),
                    """
                        TRANSACTION SAFE MODE: Transaction validation failed.
                        Check transaction signatures to confirm they have
                        been correctly arranged.
                    """)
    }
}


extension Transaction {
    /**
     Performs the steps required to ensure a transaction is correctly signed and does not produce any potential (future identified) safety issues in Transaction Safe Mode.
     */
    func validate() -> Bool {
        let instructionSigners = instructions.allSigners

        for signer in instructionSigners {
            guard signers.contains(signer) else {
                return false
            }
        }

        return true
    }
}
