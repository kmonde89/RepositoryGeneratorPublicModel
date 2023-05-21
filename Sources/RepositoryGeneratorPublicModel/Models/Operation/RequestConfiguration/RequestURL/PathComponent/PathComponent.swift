//
//  PathComponent.swift
//  
//
//  Created by Kévin Mondésir on 18/05/2023.
//

import Foundation
import RegexBuilder

extension RepositoryGeneratorPublicModel {
    public enum PathComponent: Codable {
        case string(String)
        case parameter(Parameter)
        
        public init(_ text: String, parameters: [Parameter]) throws {
            let regex = Regex {
                Anchor.startOfSubject
                One("{")
                Capture {
                    OneOrMore(.any, .reluctant)
                } transform: { capturedWord in
                    return "\(capturedWord)"
                }
                One("}")
                Anchor.endOfSubjectBeforeNewline
            }
            
            if case let .some((_, parameterName)) = text.matches(of: regex).first?.output {
                let parameter = parameters.first { $0.originalName == parameterName }
                if let parameter {
                    self = .parameter(parameter)
                } else {
                    throw ModelError.unknownParameter
                }
            } else {
                self = .string(text)
            }
        }
        
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
        let indentation = createIndentation(indentationLevel)
        return self
            .map { indentation + $0.testDescription }
            .joined(separator: ",\n")
    }
}
