//
//  Parameter.swift
//  
//
//  Created by Kévin Mondésir on 17/05/2023.
//

import Foundation

extension RepositoryGeneratorPublicModel {
    public struct Parameter: Hashable, Codable {
        public let label: String?
        public let name: String
        public let originalName: String
        public let type: String
        
        public init(label: String?, name: String, originalName: String? = nil, type: String) {
            self.label = label
            self.name = name
            self.originalName = originalName ?? name
            self.type = type
        }
        
        public var signatureDescription: String {
            guard let label else {
                return "\(self.name): \(self.type)"
            }
            return "\(label) \(self.name): \(self.type)"
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
                return "\(self.name): <#T## enter value ###".appending(">")
            }
            guard label == "_" else {
                return "\(label): <#T## enter value ###".appending(">")
            }
            return "<#T## enter value ###".appending(">")
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
