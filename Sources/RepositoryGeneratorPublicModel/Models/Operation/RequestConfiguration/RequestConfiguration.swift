//
//  RequestConfiguration.swift
//  
//
//  Created by Kévin Mondésir on 19/05/2023.
//

import Foundation

extension RepositoryGeneratorPublicModel {
    public struct RequestConfiguration: Codable {
        public enum CodingKeys: CodingKey {
            case inputDTOType
            case inputSchemaObject
            case method
            case isAuthentificated
            case requestURL
        }
        public let inputDTOType: String?
        public let inputSchemaObject: SchemaObject?
        public let method: String
        public var httpMethod: HTTPMethod {
            .init(rawValue: method) ?? .trace
        }
        public let isAuthentificated: Bool
        public let requestURL: RequestURL
        
        public init(inputDTOType: String?, inputSchemaObject: SchemaObject? = nil, method: HTTPMethod, isAuthentificated: Bool, requestURL: RequestURL) {
            self.inputDTOType = inputDTOType
            self.inputSchemaObject = inputSchemaObject
            self.method = method.rawValue
            self.isAuthentificated = isAuthentificated
            self.requestURL = requestURL
        }

        public func getInputDTODescription() -> String {
            guard case .some = self.inputDTOType else {
                return "nil"
            }
            return "try? JSONEncoder().encode(dto)"
        }

        public func isAuthentificatedDescription() -> String {
            if self.isAuthentificated {
                return "true"
            } else {
                return "false"
            }
        }

        public func getUsedParameters(_ function: Function) -> [Parameter] {
            let parameter = self.requestURL.getUsedParameters(function)
            guard let inputDTOType,
                  !inputDTOType.isEmpty else { return parameter }
            return parameter + [Parameter(label: nil, name: "dto", type: inputDTOType)]
        }
        
        private func dtoInit() -> String {
            guard let inputDTOType,
                  !inputDTOType.isEmpty else { return "" }
            return "let dto = \(createPlaceHolder("insert dto initialisation"))"
        }
        
        public func dtoInitDescription() -> String {
            return self.dtoInit()
        }
        
        public func dtoInitTestDescription(_ indentationLevel: UInt) -> String {
            let dtoInitializationString = self.dtoInit()
            guard !dtoInitializationString.isEmpty else { return "" }
            let indentation = createIndentation(4)
            return "\n\(indentation)\(dtoInitializationString)"
        }
    }
}
