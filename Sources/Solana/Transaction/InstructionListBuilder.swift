//
//  InstructionListBuilder.swift
//  Solana
//
//  Created by Nathan Lawrence on 6/14/21.
//

import Foundation

public protocol CompilableInstructionSet {

}

@resultBuilder
public struct InstructionListBuilder {

    static func buildBlock(_ components: Instruction...) -> some CompilableInstructionSet {
        Array(components)
    }

}

extension Array: CompilableInstructionSet where Element == Instruction {}
