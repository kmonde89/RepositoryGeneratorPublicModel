//
//  GlobalModel.swift
//  
//
//  Created by Kévin Mondésir on 03/07/2023.
//

import Foundation

extension RepositoryGeneratorPublicModel {
    public struct GlobalModel: Codable {
        public let operations: [Operation]
        public let schemaObjects: [SchemaObject]
        public let additionalInformation: [String: String]

        public init(operations: [Operation], schemaObjects: [SchemaObject], additionalInformation: [String: String]) {
            self.operations = operations
            self.schemaObjects = schemaObjects
            self.additionalInformation = additionalInformation
        }
    }
}
