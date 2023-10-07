//
//  SchemaObject.swift
//  
//
//  Created by Kévin Mondésir on 03/07/2023.
//

import Foundation



extension RepositoryGeneratorPublicModel {
    /**
     Representation of an open api schema object.

     Schema Object allows the definition of input and output data types.
     See open api [documentation](https://swagger.io/specification/#schema-object).
     */
    public class SchemaObject: Codable {
        /// Object name  from the openAPI document. Only available for referenced schemaObject.
        ///
        ///Yaml representation of a schema object:
        /// ```
        ///components:
        ///  schemas:
        ///    Pepper:
        ///      type: object
        ///      properties:
        ///        name:
        ///          type: string
        /// ```
        /// For this example the ``name`` will be set with the value **Pepper**
        public let name: String?
        /// Object custom name (alias set using RepoScribe)
        public let customName: String?
        /// Object reference  from the openAPI document
        public let ownReference: String?
        /// The ``type`` property following [json-schema-validation specification](https://datatracker.ietf.org/doc/html/draft-bhutton-json-schema-validation-00#section-6.1.1) followed by openapi can either be *"null"*, *"boolean"*, *"object"*, *"array"*, *"number"*, *"integer"* or *"string"*.
        public let type: String?
        /// The ``customType`` is a custom made variation of the ``type`` property that can be set  using RepoScribe application.
        public let customType: String?
        /// Object description from the openAPI document
        public let description: String?
        /// Object format from the openAPI document
        public let format: String?
        /// Object enumeration from the openAPI document
        public let enumeration: [String]?
        /// Object propertyKey from the openAPI document
        public let propertyKey: String?
        /// Object custom propertyKey (alias set using RepoScribe)
        public let customPropertyKey: String?

        ///Childrens will are representation of properties within a schema object.
        ///
        ///Yaml representation of a schema object:
        /// ```
        /// type: object
        /// properties:
        ///   id:
        ///     type: integer
        ///     format: int64
        ///   name:
        ///     type: string
        /// ```
        /// In this example ``childrens`` will contains two ``SchemaObject`` one for the id and another for the name
        public let childrens: [SchemaObject]
        /// The required property is the list of property within a schema object that are required.
        ///
        /// Yaml represetation of a schema object
        /// ```
        /// type: object
        /// properties:
        ///   id:
        ///     type: integer
        ///     format: int64
        ///   name:
        ///     type: string
        /// required:
        /// - name
        /// ```
        /// In this example the name property shouldn't be absent when sending or receiving this schemaObject from the api call.
        ///
        public let required: [String]?
        /// The reference property is available for schemaObject possesing a reference within the openapi specification.
        ///
        ///Yaml representation of a schema object:
        /// ```
        ///components:
        ///  schemas:
        ///    Pepper:
        ///      type: object
        ///      properties:
        ///        name:
        ///          type: string
        /// ```
        /// For this example the ``reference`` property will be set with the value **"#/components/schemas/Pepper"**.
        ///
        public let reference: String?
        /// The ``minimum`` property represent an inclusive lower limit for a numeric instance.
        public let minimum: Double?
        /// The ``maximum`` property represent an inclusive lower limit for a numeric instance.
        public let maximum: Double?
        /// The ``items`` property is only available for schemaObject of ``type``  **array**
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

        /// Computed variable displaying the object type when it is possible and displaying a placeholder when it is not possible.
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
