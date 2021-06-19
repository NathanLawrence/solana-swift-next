//
//  File.swift
//  
//
//  Created by Nathan Lawrence on 6/14/21.
//

import Foundation

/**
 An ordered, atomic set of instructions to be applied on the Solana blockchain, along with basic information on how they should be signed.
 */
public protocol Transaction {
    associatedtype Instructions: CompilableInstructionSet
    @InstructionListBuilder var instructions: Instructions { get }
}
