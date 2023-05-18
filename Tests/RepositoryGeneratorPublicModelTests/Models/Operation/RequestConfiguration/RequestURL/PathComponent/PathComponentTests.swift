//
//  PathComponentTests.swift
//  
//
//  Created by Kévin Mondésir on 18/05/2023.
//

import XCTest
@testable import RepositoryGeneratorPublicModel

final class PathComponentTests: XCTestCase {
    func test_parameter() throws {
        try self.createTestCase(
            given: .string("articles"),
            then: { pathComponent in
                XCTAssertNil(pathComponent.parameter,
                             "pathComponent.parameter should be nil")
            })
        try self.createTestCase(
            given: .parameter(.init(label: nil, name: "name", type: "String")),
            then: { pathComponent in
                let parameter = try XCTUnwrap(pathComponent.parameter,
                                              "pathComponent.parameter should not be nil")
                XCTAssertNil(parameter.label, "parameter.label should be nil")
                XCTAssertEqual(parameter.name, "name", "parameter.name should be equal to 'name'")
                XCTAssertEqual(parameter.originalName, "name", "parameter.originalName should be equal to 'name'")
                XCTAssertEqual(parameter.type, "String", "parameter.type should be equal to 'String'")
            })
    }

    func test_description() throws {
        try self.createTestCase(
            given: .string("articles"),
            then: { pathComponent in
                XCTAssertEqual(pathComponent.description, "articles", "pathComponent.description should be equal to 'articles'")
            })
        try self.createTestCase(
            given: .parameter(.init(label: nil, name: "name", type: "String")),
            then: { pathComponent in
                XCTAssertEqual(pathComponent.description, "{name}", "pathComponent.description should be equal to '{name}'")
            })
    }

    func test_exportDescription() throws {
        try self.createTestCase(
            given: .string("articles"),
            then: { pathComponent in
                XCTAssertEqual(pathComponent.exportDescription, "\"articles\"", "pathComponent.exportDescription should be equal to '\"articles\"'")
            })
        try self.createTestCase(
            given: .parameter(.init(label: nil, name: "name", type: "String")),
            then: { pathComponent in
                XCTAssertEqual(pathComponent.exportDescription, "name", "pathComponent.exportDescription should be equal to 'name'")
            })
    }

    func test_testDescription() throws {
        try self.createTestCase(
            given: .string("articles"),
            then: { pathComponent in
                XCTAssertEqual(pathComponent.testDescription, "\"articles\"", "pathComponent.testDescription should be equal to '\"articles\"'")
            })
        try self.createTestCase(
            given: .parameter(.init(label: nil, name: "name", type: "String")),
            then: { pathComponent in
                XCTAssertEqual(pathComponent.testDescription, "<#T## enter name ###>", "pathComponent.testDescription should be equal to '<#T## enter name ###>'")
            })
    }

    func createTestCase(
        given pathComponent: RepositoryGeneratorPublicModel.PathComponent,
        then: (_ pathComponent: RepositoryGeneratorPublicModel.PathComponent) throws -> Void
    ) throws {
        try then(pathComponent)
    }

    func test_array_testDescription() throws {
        try self.createArrayTestCase(
            given: [
                .string("articles"),
                .parameter(.init(label: nil, name: "articleIdentifier", type: "Int"))
            ],
            then: { pathComponents in
                XCTAssertEqual(
                    pathComponents.testDescription(1),
                    "\t\"articles\",\n\t<#T## enter articleIdentifier ###>",
                    "pathComponents.testDescription(1) should be equal to '\t\"articles\",\n\t<#T## enter articleIdentifier ###>'")
            })
    }

    func createArrayTestCase(
        given pathComponents: [RepositoryGeneratorPublicModel.PathComponent],
        then: (_ pathComponents: [RepositoryGeneratorPublicModel.PathComponent]) throws -> Void
    ) throws {
        try then(pathComponents)
    }
}
