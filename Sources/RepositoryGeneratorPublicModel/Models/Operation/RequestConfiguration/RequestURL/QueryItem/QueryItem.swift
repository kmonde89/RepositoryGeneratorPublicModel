//
//  QueryItem.swift
//  
//
//  Created by Kévin Mondésir on 18/05/2023.
//

import Foundation

extension RepositoryGeneratorPublicModel {
    public struct QueryItem {
        public enum Value {
            case parameter(Parameter)
            case string(String)
            
            public var parameter: Parameter? {
                guard case let .parameter(parameter) = self else { return nil }
                return parameter
            }
        }

        public let key: String
        public let value: Value

        public init(key: String, value: Value) {
            self.key = key
            self.value = value
        }

        public var description: String {
            switch self.value {
            case .string(let text):
                return ".init(key: \"\(self.key)\", value: \"\(text)\")"
            case .parameter(let parameter) where parameter.type == "String":
                return ".init(key: \"\(self.key)\", value: \(parameter.name))"
            case .parameter(let parameter):
                return ".init(key: \"\(self.key)\", value: String(\(parameter.name)))"
            }
        }

        public var testDescription: String {
            switch self.value {
            case .string(let text):
                return ".init(key: \"\(self.key)\", value: \"\(text)\")"
            case .parameter(let parameter):
                return ".init(key: \"\(self.key)\", value: \"<#T## enter \(parameter.name)###".appending(">\")")
            }
        }
    }
}
