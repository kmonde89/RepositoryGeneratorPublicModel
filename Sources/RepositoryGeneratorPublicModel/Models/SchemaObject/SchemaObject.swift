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
        public let minimum: Double?
        public let maximum: Double?
        public let items: SchemaObject?

        public init(name: String? = nil, customName: String? = nil, ownReference: String? = nil, type: String? = nil, customType: String? = nil, description: String? = nil, format: String? = nil, enumeration: [String]? = nil, propertyKey: String? = nil, customPropertyKey: String? = nil, childrens: [SchemaObject] = [], required: [String]? = nil, reference: String? = nil, minimum: Double? = nil, maximum: Double? = nil, items: SchemaObject? = nil) {
            self.name = name
            self.customName = customName
            self.ownReference = ownReference
            self.type = type
            self.customType = customType
            self.description = description
            self.format = format
            self.enumeration = enumeration
            self.propertyKey = propertyKey
            self.customPropertyKey = customPropertyKey
            self.childrens = childrens
            self.required = required
            self.reference = reference
            self.minimum = minimum
            self.maximum = maximum
            self.items = items
        }

        public var typeDescription: String {
            self.getType("Enter type")
        }

        public func getType(_ placeholder: String) -> String {
            if self.type?.lowercased() == "array", let items =  self.items {
                return "[\(items.customType ?? items.type ?? createPlaceHolder(placeholder))]"
            }
            return self.customType ?? self.type ?? createPlaceHolder(placeholder)
        }
    }
}
