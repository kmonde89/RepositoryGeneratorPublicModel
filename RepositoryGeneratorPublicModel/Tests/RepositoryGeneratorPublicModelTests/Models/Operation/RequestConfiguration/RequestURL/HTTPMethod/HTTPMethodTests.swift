//
//  HTTPMethodTests.swift
//  
//
//  Created by Kévin Mondésir on 18/05/2023.
//

import XCTest
@testable import RepositoryGeneratorPublicModel

final class HTTPMethodTests: XCTestCase {
    func test_cases() {
        let rawValues = RepositoryGeneratorPublicModel
            .HTTPMethod
            .allCases
            .map { $0.rawValue }
        let expectedValues = [
            "get",
            "post",
            "put",
            "delete",
            "patch",
            "head",
            "options",
            "trace"
        ]
        XCTAssertEqual(rawValues, expectedValues)
    }
}
