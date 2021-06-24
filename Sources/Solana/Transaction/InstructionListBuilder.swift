//
//  InstructionListBuilder.swift
//  Solana
//
//  Created by Nathan Lawrence on 6/14/21.
//

import Foundation

public protocol CompilableInstructionSet {
    /**
     An array of all signatures required for an instruction or group of instructions. Used by the SDK to validate transactions in Transaction Safe Mode.
     */
    var allSigners: [TransactionKey] { get }
}

@resultBuilder
public struct InstructionListBuilder {

    static func buildBlock(_ components: TransactionInstruction...) -> some CompilableInstructionSet {
        Array(components)
    }

}

extension Array: CompilableInstructionSet where Element == TransactionInstruction {
    public var allSigners: [TransactionKey] {
        self.flatMap { instruction in
            instruction.allSigners
        }
    }
}
