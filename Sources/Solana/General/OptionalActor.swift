//
//  OptionalActor.swift
//  
//
//  Created by Nathan Lawrence on 6/18/21.
//

import Foundation

/**
 A base class that supports Foundation-based locking and unlocking of contents, optionally forcing its method calls into an actor pattern.
 */
open class OptionalActor {
    let lock = NSLock()

    public func locked<Return>(_ perform: () -> Return) -> Return {
        lock.lock()
        defer { lock.unlock() }
        return perform()
    }
}
