//
//  SchemaObject.swift
//  
//
//  Created by Kévin Mondésir on 03/07/2023.
//

import Foundation

extension RepositoryGeneratorPublicModel {
    public class SchemaObject: Codable {
        /// Object name  from the openAPI document
        public let name: String?
        /// Object custom name (alias set using RepoScribe)
        public let customName: String?
        /// Object reference  from the openAPI document
        public let ownReference: String?
        /// Object type  from the openAPI document
        public let type: String?
        /// Object custom type (alias set using RepoScribe)
        public let customType: String?
        /// Object description from the openAPI document
        public let description: String?
        /// Object format from the openAPI document
        public let format: String?
        /// Object enumeration from the openAPI document
        public let enumeration: [String]?
        /// Object propertyKey from the openAPI document
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
            self.getType("Enter type") { _ in return nil}
        }

        public func getType(_ placeholder: String,
                            searchReferencedObject: (_ reference: String) -> SchemaObject?) -> String {
            if let reference {
                guard let referencedObject = searchReferencedObject(reference) else {
                    return  createPlaceHolder(placeholder)
                }
                return referencedObject.customType ?? referencedObject.type ?? createPlaceHolder(placeholder)
            }
            if self.type?.lowercased() == "array", let items =  self.items {

                return "[\(items.getType(placeholder, searchReferencedObject: searchReferencedObject))]"
            } else if self.type?.lowercased() == "object" {
                return self.customName ?? self.name ?? createPlaceHolder(placeholder)
            }
            return self.customType ?? self.type ?? createPlaceHolder(placeholder)
        }
    }
}
