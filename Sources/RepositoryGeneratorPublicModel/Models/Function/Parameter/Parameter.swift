//
//  Parameter.swift
//  
//
//  Created by Kévin Mondésir on 17/05/2023.
//

import Foundation

extension RepositoryGeneratorPublicModel {
    public struct Parameter: Hashable, Codable {
        public static func == (lhs: RepositoryGeneratorPublicModel.Parameter, rhs: RepositoryGeneratorPublicModel.Parameter) -> Bool {
            lhs.label == rhs.label &&
            lhs.name == rhs.name &&
            lhs.originalName == rhs.originalName &&
            lhs.type == rhs.type
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(self.label)
            hasher.combine(self.name)
            hasher.combine(self.originalName)
            hasher.combine(self.type)
        }

        public let label: String?
        public let name: String
        public let originalName: String
        public let type: String
        public let schemaObject: SchemaObject?
        
        public init(label: String?, name: String, originalName: String? = nil, type: String, schemaObject: SchemaObject? = nil) {
            self.label = label
            self.name = name
            self.originalName = originalName ?? name
            self.type = type
            self.schemaObject = schemaObject
        }

        public var getTypeDescription: String {
            guard let schemaObject else {
                return self.type
            }
            if schemaObject.type?.lowercased() == "array", let items =  schemaObject.items {
                return "[\(items.customType ?? items.type ?? createPlaceHolder("Enter type"))]"
            }
            return schemaObject.customType ?? schemaObject.type ?? createPlaceHolder("Enter type")
        }
        
        public var signatureDescription: String {
            guard let label else {
                return "\(self.name): \(self.getTypeDescription)"
            }
            return "\(label) \(self.name): \(self.getTypeDescription)"
        }
        
        public var callDescription: String {
            guard let label else {
                return "\(self.name): \(self.name)"
            }
            guard label == "_" else {
                return "\(label): \(self.name)"
            }
            return self.name
        }
        
        public var customInputCallDescription: String {
            guard let label else {
                return "\(self.name): " + createPlaceHolder("enter value")
            }

            guard label == "_" else {
                return "\(label): " + createPlaceHolder("enter value")
            }
            return createPlaceHolder("enter value")
        }
    }
}
extension Array<RepositoryGeneratorPublicModel.Parameter> {
    public func signatureDescription() -> String {
        return self
            .map { $0.signatureDescription }
            .joined(separator: ", ")
    }
    
    public func callDescription() -> String {
        return self
            .map { $0.callDescription }
            .joined(separator: ", ")
    }
    
    public func testSignatureDescription(_ indentationLevel: UInt = 2) -> String {
        let indentation = createIndentation(indentationLevel)
        return self
            .map { indentation + $0.signatureDescription }
            .joined(separator: ",\n")
    }
    
    public func customInputCallDescription(_ indentationLevel: UInt = 3) -> String {
        guard !self.isEmpty else { return "" }
        let indentation = createIndentation(indentationLevel)
        return self
            .map { indentation + $0.customInputCallDescription }
            .joined(separator: ",\n")
    }
}
