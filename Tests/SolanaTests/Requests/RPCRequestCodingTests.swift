//
//  RPCRequestCodingTests.swift
//  SolanaTests
//
//  Created by Nathan Lawrence on 5/24/21.
//

import XCTest
@testable import Solana

class RPCRequestCodingTests: XCTestCase {

    func testSampleRequestCodes() throws {
        struct SampleRequest: RPCRequest, Equatable {
            static let methodName = "sampleRequest"

            typealias Response = Int

            typealias Value = Base58

            typealias KeyedBody = NoKeyedBody

            var payload: RPCRequestPayload<Base58, NoKeyedBody> {
                return RPCRequestPayload(value: value, requestMetadata: NoKeyedBody())
            }

            var value: Base58
        }

        let request = SampleRequest(value: .init(string: "abc")!)
        let coder = JSONEncoder()
        let encoded = try coder.encode(TaggedRPCRequest(request, id: 1))
        XCTAssertEqual(String(data: encoded, encoding: .utf8),
                       #"{"jsonrpc":"2.0","method":"sampleRequest","id":1,"params":["abc"]}"#)

        XCTAssertJSONEqual(#"{"jsonrpc":"2.0","method":"sampleRequest","id":1,"params":["abc"]}"#.data(using: .utf8)!, encoded)
    }

    func testSampleRequestWithKeyedBodyCodes() throws {

        struct HelloWorld: Codable, Hashable, RPCRequestKeyedBody {
            var text = "hello world"
        }

        struct SampleRequest: RPCRequest, Equatable {
            typealias Response = Int

            typealias Value = Base58

            typealias KeyedBody = HelloWorld

            static let methodName: String = "sampleRequest"

            var payload: RPCRequestPayload<Base58, HelloWorld> {
                return RPCRequestPayload(value: value, requestMetadata: HelloWorld())
            }

            var value: Base58
        }

        let request = SampleRequest(value: .init(string: "abc")!)
        let coder = JSONEncoder()
        let encoded = try coder.encode(TaggedRPCRequest(request, id: 1))
        XCTAssertEqual(String(data: encoded, encoding: .utf8),
                       #"{"jsonrpc":"2.0","method":"sampleRequest","id":1,"params":["abc",{"text":"hello world"}]}"#)
    }

}
