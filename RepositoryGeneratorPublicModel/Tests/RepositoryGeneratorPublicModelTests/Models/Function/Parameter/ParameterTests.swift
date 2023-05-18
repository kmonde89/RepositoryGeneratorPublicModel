//
//  ParameterTests.swift
//  
//
//  Created by Kévin Mondésir on 17/05/2023.
//

import XCTest
@testable import RepositoryGeneratorPublicModel

final class ParameterTests: XCTestCase {
    func test_signatureDescription() throws {
        try self.createTestCase(
            label: nil,
            name: "name",
            originalName: nil,
            type: "String",
            then: { parameter in
                XCTAssertEqual(
                    parameter.signatureDescription,
                    "name: String",
                    "parameter.signatureDescription should be equal to 'name: String'")
        })
        try self.createTestCase(
            label: "label",
            name: "name",
            originalName: nil,
            type: "String",
            then: { parameter in
                XCTAssertEqual(
                    parameter.signatureDescription,
                    "label name: String",
                    "parameter.signatureDescription should be equal to 'label name: String'")
        })
    }

    func test_callDescription() throws {
        try self.createTestCase(
            label: nil,
            name: "name",
            originalName: nil,
            type: "String",
            then: { parameter in
                XCTAssertEqual(
                    parameter.callDescription,
                    "name: name",
                    "parameter.callDescription should be equal to 'name: name'")
        })
        try self.createTestCase(
            label: "label",
            name: "name",
            originalName: nil,
            type: "String",
            then: { parameter in
                XCTAssertEqual(
                    parameter.callDescription,
                    "label: name",
                    "parameter.callDescription should be equal to 'label: name'")
        })
    }

    func test_customInputCallDescription() throws {
        try self.createTestCase(
            label: nil,
            name: "name",
            originalName: nil,
            type: "String",
            then: { parameter in
                XCTAssertEqual(
                    parameter.customInputCallDescription,
                    "name: <#T## enter value ###>",
                    "parameter.customInputCallDescription should be equal to 'name: <#T## enter value ###>'")
        })
        try self.createTestCase(
            label: "label",
            name: "name",
            originalName: nil,
            type: "String",
            then: { parameter in
                XCTAssertEqual(
                    parameter.customInputCallDescription,
                    "label: <#T## enter value ###>",
                    "parameter.customInputCallDescription should be equal to 'label: <#T## enter value ###>'")
        })
    }
    
    func createTestCase(
        label: String?,
        name: String,
        originalName: String? = nil,
        type: String,
        then: (_ parameter: Parameter) throws -> Void ) throws {
            let parameter = Parameter(
                label: label,
                name: name,
                originalName: originalName,
                type: type)
            try then(parameter)
    }
    
    func test_array_signatureDescription() throws {
        try self.createArrayTestCase(
            label: nil,
            then: { parameters in
                XCTAssertEqual(
                    parameters.signatureDescription(),
                    "name1: String, name2: String",
                    "parameters.signatureDescription() should be equal to 'name1: String, name2: String'")
            })
        try self.createArrayTestCase(
            label: "label",
            then: { parameters in
                XCTAssertEqual(
                    parameters.signatureDescription(),
                    "label1 name1: String, label2 name2: String",
                    "parameters.signatureDescription() should be equal to 'label1 name1: String, label2 name2: String'")
            })
    }

    func test_array_callDescription() throws {
        try self.createArrayTestCase(
            label: nil,
            then: { parameters in
                XCTAssertEqual(
                    parameters.callDescription(),
                    "name1: name1, name2: name2",
                    "parameters.callDescription() should be equal to 'name1: name1, name2: name2'")
            })
        try self.createArrayTestCase(
            label: "label",
            then: { parameters in
                XCTAssertEqual(
                    parameters.callDescription(),
                    "label1: name1, label2: name2",
                    "parameters.callDescription() should be equal to 'label1: name1, label2: name2'")
            })
    }

    func test_array_testSignatureDescription() throws {
        try self.createArrayTestCase(
            label: nil,
            then: { parameters in
                XCTAssertEqual(
                    parameters.testSignatureDescription(),
                    "\t\tname1: String,\n\t\tname2: String",
                    "parameters.testSignatureDescription() should be equal to '\t\tname1: String,\n\t\tname2: String'")
            })
        try self.createArrayTestCase(
            label: "label",
            then: { parameters in
                XCTAssertEqual(
                    parameters.testSignatureDescription(),
                    "\t\tlabel1 name1: String,\n\t\tlabel2 name2: String",
                    "parameters.testSignatureDescription() should be equal to '\t\tlabel1 name1: String,\n\t\tlabel2 name2: String'")
            })
    }

    func test_array_customInputCallDescription() throws {
        try self.createArrayTestCase(
            label: nil,
            then: { parameters in
                XCTAssertEqual(
                    parameters.customInputCallDescription(),
                    "\t\t\tname1: <#T## enter value ###>,\n\t\t\tname2: <#T## enter value ###>",
                    "parameters.customInputCallDescription() should be equal to '\t\t\tname1: <#T## enter value ###>,\n\t\t\tname2: <#T## enter value ###>'")
            })
        try self.createArrayTestCase(
            label: "label",
            then: { parameters in
                XCTAssertEqual(
                    parameters.customInputCallDescription(),
                    "\t\t\tlabel1: <#T## enter value ###>,\n\t\t\tlabel2: <#T## enter value ###>",
                    "parameters.customInputCallDescription() should be equal to '\t\t\tlabel1: <#T## enter value ###>,\n\t\t\tlabel2: <#T## enter value ###>'")
            })
    }

    func createArrayTestCase(
        itemsCount: UInt = 2,
        label: String?,
        name: String = "name",
        type: String = "String",
        then: (_ parameters: [Parameter]) throws -> Void ) throws {
            let parameters = (0..<itemsCount)
                .map {
                    guard let label else {
                        return Parameter(
                            label: nil,
                            name: "\(name)\($0 + 1)",
                            originalName: nil,
                            type: type)
                    }
                    return Parameter(
                        label: "\(label)\($0 + 1)",
                        name: "\(name)\($0 + 1)",
                        originalName: nil,
                        type: type)
                }
            try then(parameters)
    }
}
