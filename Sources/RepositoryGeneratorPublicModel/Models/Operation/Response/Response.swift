//
//  Response.swift
//  
//
//  Created by Kévin Mondésir on 19/05/2023.
//

import Foundation

extension RepositoryGeneratorPublicModel {
    public struct Response: Codable {
        public let statusCode: Int?
        public let schemaObject: SchemaObject?
        
        public init(statusCode: Int?,
                    schemaObject: SchemaObject?) {
            self.statusCode = statusCode
            self.schemaObject = schemaObject
        }
        
        public var description: String {
            guard case .some(let schemaObject) = self.schemaObject else {
                return """
.responsePublisher()
\(createIndentation(3)).map { _ in }
"""
            }
            let name = schemaObject.customName ?? schemaObject.name ?? createPlaceHolder("enter dto type")
            return """
.responseDecodablePublisher(of: \(name).self)
\(createIndentation(3)).map { \(createPlaceHolder("map to model")) }
"""
        }
    }
}
