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
    }
}
