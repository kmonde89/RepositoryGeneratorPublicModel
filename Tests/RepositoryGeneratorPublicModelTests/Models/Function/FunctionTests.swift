//
//  FunctionTests.swift
//  
//
//  Created by Kévin Mondésir on 18/05/2023.
//

import XCTest
@testable import RepositoryGeneratorPublicModel

final class Function: XCTestCase {
    func test_description() {
        // Given
        let function = RepositoryGeneratorPublicModel.Function(name: "waterPlant",
                                parameters: [
                                    .init(label: nil, name: "volume", type: "L")
                                ],
                                returnValue: .publisher(output: "Bool", error: "Error"))
        // Then
        XCTAssertEqual(
            function.description,
            "func waterPlant(volume: L) -> AnyPublisher<Bool, Error>",
            "function.description should be equal to 'func waterPlant(volume: L) -> AnyPublisher<Bool, Error>'")
    }
    
    func test_capitalizedName() {
        // Given
        let function = RepositoryGeneratorPublicModel.Function(name: "waterPlant",
                                parameters: [
                                    .init(label: nil, name: "volume", type: "L")
                                ],
                                returnValue: .publisher(output: "Bool", error: "Error"))
        // Then
        XCTAssertEqual(
            function.capitalizedName,
            "WaterPlant",
            "function.capitalizedName should be equal to 'WaterPlant'")
    }
}
