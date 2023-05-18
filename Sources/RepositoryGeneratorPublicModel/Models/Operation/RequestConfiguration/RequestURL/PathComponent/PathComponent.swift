//
//  PathComponent.swift
//  
//
//  Created by Kévin Mondésir on 18/05/2023.
//

import Foundation

extension RepositoryGeneratorPublicModel {
    public enum PathComponent {
        case string(String)
        case parameter(Parameter)
        
        public var parameter: Parameter? {
            guard case let .parameter(parameter) = self else {
                return nil
            }
            return parameter
        }
        
        public var description: String {
            switch self {
            case .parameter(let parameter):
                return "{\(parameter.name)}"
            case .string(let text):
                return text
            }
        }

        public var exportDescription: String {
            switch self {
            case .string(let text):
                return "\"\(text)\""
            case .parameter(let parameter):
                return parameter.name
            }
        }

        public var testDescription: String {
            switch self {
            case .string(let text):
                return "\"\(text)\""
            case .parameter(let parameter):
                return "<#T## enter \(parameter.name) ###".appending(">")
            }
        }
    }
}

extension Array<RepositoryGeneratorPublicModel.PathComponent> {
    public func testDescription(_ indentationLevel: UInt = 7) -> String {
        guard !self.isEmpty else { return "" }
        let indentation = (0..<indentationLevel)
            .map { _ in "\t" }
            .joined()
        return self
            .map { indentation + $0.testDescription }
            .joined(separator: ",\n")
    }
}
