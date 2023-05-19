//
//  RequestConfiguration.swift
//  
//
//  Created by Kévin Mondésir on 19/05/2023.
//

import Foundation

extension RepositoryGeneratorPublicModel {
    public struct RequestConfiguration {
        public let inputDTOType: String?
        public let method: HTTPMethod
        public let isAuthnetificated: Bool
        public let requestURL: RequestURL
        
        public init(inputDTOType: String?, method: HTTPMethod, isAuthnetificated: Bool, requestURL: RequestURL) {
            self.inputDTOType = inputDTOType
            self.method = method
            self.isAuthnetificated = isAuthnetificated
            self.requestURL = requestURL
        }

        public func getInputDTODescription() -> String {
            guard case .some = self.inputDTOType else {
                return "nil"
            }
            return "try? JSONEncoder().encode(dto)"
        }

        public func isAuthentificatedDescription() -> String {
            if self.isAuthnetificated {
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
