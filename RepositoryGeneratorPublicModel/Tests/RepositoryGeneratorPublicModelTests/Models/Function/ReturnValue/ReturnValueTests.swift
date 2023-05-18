//
//  ReturnValueTests.swift
//  
//
//  Created by Kévin Mondésir on 18/05/2023.
//

import XCTest
@testable import RepositoryGeneratorPublicModel

final class ReturnValueTests: XCTestCase {
    func test_description() throws {
        try self.createTestCase(
            given: .publisher(output: "Int", error: "Never"),
            then: { returnValue in
                XCTAssertEqual(
                    returnValue.description,
                    "AnyPublisher<Int, Never>",
                    "returnValue.description should be equal to 'AnyPublisher<Int, Never>'")
            })
        try self.createTestCase(
            given: .standard(type: "Int"),
            then: { returnValue in
                XCTAssertEqual(
                    returnValue.description,
                    "Int",
                    "returnValue.description should be equal to 'Int'")
            })
    }

    func test_publisherMapError() throws {
        try self.createTestCase(
            given: .standard(type: "Int"),
            then: { returnValue in
                XCTAssertEqual(
                    returnValue.publisherMapError,
                    "",
                    "returnValue.publisherMapError should be equal to ''")
            })
        try self.createTestCase(
            given: .publisher(output: "Int", error: "Error"),
            then: { returnValue in
                XCTAssertEqual(
                    returnValue.publisherMapError,
                    ".mapError { $0 as Error }",
                    "returnValue.publisherMapError should be equal to '.mapError { $0 as Error }'")
            })
        try self.createTestCase(
            given: .publisher(output: "Int", error: "CustomError"),
            then: { returnValue in
                XCTAssertEqual(
                    returnValue.publisherMapError,
                    ".mapError { <#T## insert error mapping to CustomError###> }",
                    "returnValue.publisherMapError should be equal to '.mapError { <#T## insert error mapping to CustomError###> }'")
            })
    }

    func test_resultTypeDecription() throws {
        try self.createTestCase(
            given: .standard(type: "Int"),
            then: { returnValue in
                XCTAssertEqual(
                    returnValue.resultTypeDecription,
                    "",
                    "returnValue.resultTypeDecription should be equal to ''")
            })
        try self.createTestCase(
            given: .publisher(output: "Int", error: "Error"),
            then: { returnValue in
                XCTAssertEqual(
                    returnValue.resultTypeDecription,
                    "Result<Int, Error>",
                    "returnValue.resultTypeDecription should be equal to 'Result<Int, Error>'")
            })
    }


    func createTestCase(
        given returnValue: ReturnValue,
        then: (_ returnValue: ReturnValue) throws -> Void
    ) throws {
        try then(returnValue)
    }
}
