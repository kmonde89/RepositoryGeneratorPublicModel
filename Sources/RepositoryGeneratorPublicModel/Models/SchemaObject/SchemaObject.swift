//
//  SchemaObject.swift
//  
//
//  Created by Kévin Mondésir on 03/07/2023.
//

import Foundation

extension RepositoryGeneratorPublicModel {
    public class SchemaObject: Codable {
        public let name: String?
        public let customName: String?
        public let ownReference: String?
        public let type: String?
        public let customType: String?
        public let description: String?
        public let format: String?
        public let enumeration: [String]?
        public let propertyKey: String?
        public let customPropertyKey: String?
        public let childrens: [SchemaObject]
        public let required: [String]?
        public let reference: String?
        public let minimum: Int?
        public let items: SchemaObject?
    }
}
