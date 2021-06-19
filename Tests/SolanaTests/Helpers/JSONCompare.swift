//
//  File.swift
//  
//
//  Created by Nathan Lawrence on 6/3/21.
//

import Foundation
import XCTest

extension XCTestCase {

    /**
     Perform basic tests to attempt to prove JSON equality, noting some cases may be missed.
     */
    func XCTAssertJSONEqual(_ lhs: Data, _ rhs: Data) {
        do {
            let lhsObject = try XCTUnwrap(JSONSerialization.jsonObject(with: lhs, options: []) as? [String: Any])
            let rhsObject = try XCTUnwrap(JSONSerialization.jsonObject(with: rhs, options: []) as? [String: Any])

            XCTAssertEqual(lhsObject.keys.sorted(),
                           rhsObject.keys.sorted())

            let lhsString = String(data: lhs, encoding: .utf8)?.replacingOccurrences(of: #"\s"#, with: "", options: [.regularExpression])
            let rhsString = String(data: rhs, encoding: .utf8)?.replacingOccurrences(of: #"\s"#, with: "", options: [.regularExpression])
            XCTAssertEqual(lhsString, rhsString)
        } catch {
            XCTFail("Deserialization of one or more objects failed.")
        }
    }
}
