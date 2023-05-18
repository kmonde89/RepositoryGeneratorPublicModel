//
//  QueryItemTests.swift
//  
//
//  Created by Kévin Mondésir on 18/05/2023.
//

import XCTest
@testable import RepositoryGeneratorPublicModel

final class QueryItemTests: XCTestCase {
    func test_description() throws {
        try self.createTestCase(
            given: .init(key: "x", value: .string("test")),
            then: { queryItem in
                XCTAssertEqual(queryItem.description, ".init(key: \"x\", value: \"test\")")
            })
        try self.createTestCase(
            given: .init(key: "x", value: .parameter(.init(label: nil, name: "name", type: "Int"))),
            then: { queryItem in
                XCTAssertEqual(queryItem.description, ".init(key: \"x\", value: String(name))")
            })
        try self.createTestCase(
            given: .init(key: "x", value: .parameter(.init(label: nil, name: "name", type: "Int"))),
            then: { queryItem in
                XCTAssertEqual(queryItem.description, ".init(key: \"x\", value: String(name))")
            })
    }

    func test_testDescription() throws {
        try self.createTestCase(
            given: .init(key: "x", value: .string("test")),
            then: { queryItem in
                XCTAssertEqual(queryItem.testDescription, ".init(key: \"x\", value: \"test\")")
            })
        try self.createTestCase(
            given: .init(key: "x", value: .parameter(.init(label: nil, name: "name", type: "Int"))),
            then: { queryItem in
                XCTAssertEqual(queryItem.testDescription, ".init(key: \"x\", value: \"<#T## enter name###>\")")
            })
    }

    func createTestCase(
        given queryItem: RepositoryGeneratorPublicModel.QueryItem,
        then: (_ queryItem: RepositoryGeneratorPublicModel.QueryItem) throws -> Void
    ) throws {
        try then(queryItem)
    }
}
