//
//  Base58.swift
//  Solana
//
//  Created by Nathan Lawrence on 5/24/21.
//

import Foundation
import CommonCrypto
import BigInt

/**
 Data represented as a Base58-encoded string.
 */
public struct Base58: Codable {
    /**
     The underlying data the Base58 structure represents.
     */
    public var data: Data {
        Data(dataBytes)
    }

    /**
     The underlying data the Base58 structure represents, in blocks of 8 bits.
     */
    public var dataBytes: [Byte]

    public init(_ dataBytes: [Byte]) {
        self.dataBytes = dataBytes
    }

    public init?(string: String) {
        guard let bytes = Base58Tools.base58Decode(string) else {
            return nil
        }
        self.init(bytes)
    }

    public var stringValue: String {
        Base58Tools.base58Encode(dataBytes)
    }

    public func encode(to encoder: Encoder) throws {
        var field = encoder.singleValueContainer()
        try field.encode(stringValue)
    }

    public init(from decoder: Decoder) throws {
        var field = try decoder.singleValueContainer()
        let string = try field.decode(String.self)
        guard let bytes = Base58Tools.base58Decode(string) else {
            throw DecodingError.typeMismatch(Base58.self,.init(codingPath: [], debugDescription: "Could not unwrap string to base58"))
        }
        self.init(bytes)
    }
}

/**
 Derived from keefertaylor/base58swift, with necessary modifications to align with standards.
 */
internal enum Base58Tools {
    /// Length of checksum appended to Base58Check encoded strings.
    private static let checksumLength = 4

    private static let alphabet = [Byte]("123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz".utf8)
    private static let zero = BigUInt(0)
    private static let radix = BigUInt(alphabet.count)

    /// Encode the given bytes into a Base58Check encoded string.
    /// - Parameter bytes: The bytes to encode.
    /// - Returns: A base58check encoded string representing the given bytes, or nil if encoding failed.
    public static func base58CheckEncode(_ bytes: [Byte]) -> String {
        let checksum = calculateChecksum(bytes)
        let checksummedBytes = bytes + checksum
        return Base58Tools.base58Encode(checksummedBytes)
    }

    /// Decode the given Base58Check encoded string to bytes.
    /// - Parameter input: A base58check encoded input string to decode.
    /// - Returns: Bytes representing the decoded input, or nil if decoding failed.
    public static func base58CheckDecode(_ input: String) -> [Byte]? {
        guard let decodedChecksummedBytes = base58Decode(input) else {
            return nil
        }

        let decodedChecksum = decodedChecksummedBytes.suffix(checksumLength)
        let decodedBytes = decodedChecksummedBytes.prefix(upTo: decodedChecksummedBytes.count - checksumLength)
        let calculatedChecksum = calculateChecksum([Byte](decodedBytes))

        guard decodedChecksum.elementsEqual(calculatedChecksum, by: { $0 == $1 }) else {
            return nil
        }
        return Array(decodedBytes)
    }

    /// Encode the given bytes to a Base58 encoded string.
    /// - Parameter bytes: The bytes to encode.
    /// - Returns: A base58 encoded string representing the given bytes, or nil if encoding failed.
    public static func base58Encode(_ bytes: [Byte]) -> String {
        var answer: [Byte] = []
        var integerBytes = BigUInt(Data(bytes))

        while integerBytes > 0 {
            let (quotient, remainder) = integerBytes.quotientAndRemainder(dividingBy: radix)
            answer.insert(alphabet[Int(remainder)], at: 0)
            integerBytes = quotient
        }

        let prefix = Array(bytes.prefix { $0 == 0 }).map { _ in alphabet[0] }
        answer.insert(contentsOf: prefix, at: 0)

        // swiftlint:disable force_unwrapping
        // Force unwrap as the given alphabet will always decode to UTF8.
        return String(bytes: answer, encoding: String.Encoding.utf8)!
        // swiftlint:enable force_unwrapping
    }

    /// Decode the given base58 encoded string to bytes.
    /// - Parameter input: The base58 encoded input string to decode.
    /// - Returns: Bytes representing the decoded input, or nil if decoding failed.
    public static func base58Decode(_ input: String) -> [Byte]? {
        var answer = zero
        var i = BigUInt(1)
        let byteString = [Byte](input.utf8)

        for char in byteString.reversed() {
            guard let alphabetIndex = alphabet.firstIndex(of: char) else {
                return nil
            }
            answer += (i * BigUInt(alphabetIndex))
            i *= radix
        }

        let bytes = answer.serialize()
        // For every leading one on the input we need to add a leading 0 on the output
        let leadingOnes = byteString.prefix(while: { value in value == alphabet[0]})
        let leadingZeros: [Byte] = Array(repeating: 0, count: leadingOnes.count)
        return leadingZeros + bytes
    }

    /// Calculate a checksum for a given input by hashing twice and then taking the first four bytes.
    /// - Parameter input: The input bytes.
    /// - Returns: A byte array representing the checksum of the input bytes.
    private static func calculateChecksum(_ input: [Byte]) -> [Byte] {
        let hashedData = sha256(input)
        let doubleHashedData = sha256(hashedData)
        let doubleHashedArray = Array(doubleHashedData)
        return Array(doubleHashedArray.prefix(checksumLength))
    }

    /// Create a sha256 hash of the given data.
    /// - Parameter data: Input data to hash.
    /// - Returns: A sha256 hash of the input data.
    private static func sha256(_ data: [Byte]) -> [Byte] {
        let res = NSMutableData(length: Int(CC_SHA256_DIGEST_LENGTH))!
        CC_SHA256(
            (Data(data) as NSData).bytes,
            CC_LONG(data.count),
            res.mutableBytes.assumingMemoryBound(to: Byte.self)
        )
        return [Byte](res as Data)
    }
}
