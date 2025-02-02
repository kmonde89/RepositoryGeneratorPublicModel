//
//  GlobalModel.swift
//  
//
//  Created by Kévin Mondésir on 03/07/2023.
//

import Foundation

extension RepositoryGeneratorPublicModel {
    public struct GlobalModel: Codable {
        public let repositoryName: String
        public let operations: [Operation]
        public let schemaObjects: [SchemaObject]
        public let additionalInformation: [String: String]

        public init(repositoryName: String, operations: [Operation], schemaObjects: [SchemaObject], additionalInformation: [String: String]) {
            self.repositoryName = repositoryName
            self.operations = operations
            self.schemaObjects = schemaObjects
            self.additionalInformation = additionalInformation
        }
    }
}
