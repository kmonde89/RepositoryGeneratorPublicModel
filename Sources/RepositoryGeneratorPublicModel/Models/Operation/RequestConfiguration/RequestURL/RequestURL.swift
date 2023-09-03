//
//  RequestURL.swift
//  
//
//  Created by Kévin Mondésir on 19/05/2023.
//

import Foundation

extension RepositoryGeneratorPublicModel {
    public struct RequestURL: Codable {
        public let pathComponents: [PathComponent]
        public let queryItems: [QueryItem]?
        
        public init(pathComponents: [PathComponent], queryItems: [QueryItem]?) {
            self.pathComponents = pathComponents
            self.queryItems = queryItems
        }
        
        public static func getComponents(path: String, parameters: [Parameter]) -> [PathComponent] {
            do {
                var path = path
                path.trimPrefix("/")
                let components = path.components(separatedBy: "/")
                if !components.isEmpty {
                    return try components.map { try PathComponent.init($0, parameters: parameters) }
                } else {
                    let value = [try PathComponent.init(path, parameters: parameters)]
                    return value
                }
            } catch {
                return []
            }
        }

        public func exportPath() -> String {
            return self.pathComponents
                .map { $0.exportDescription }
                .joined(separator: ", ")
        }

        public func exportPathForTest() -> String {
            return self.pathComponents
                .map { $0.testDescription }
                .joined(separator: ", ")
        }
        
        public func exportQueryItems() -> String {
            guard let queryItems else { return "nil" }
            return "[\(queryItems.map { $0.description }.joined(separator: ", "))]"
            
        }
        
        public func exportTestQueryItems() -> String {
            guard let queryItems else { return "nil" }
            return "[\(queryItems.map { $0.testDescription }.joined(separator: ", "))]"
        }

        public func getUsedParameters(_ function: Function) -> [Parameter] {
            let queryItemsParameter = self.queryItems?.compactMap { $0.value.parameter } ?? []
            let pathComponentsParameter = self.pathComponents.compactMap { $0.parameter }
            let parameters = Set(queryItemsParameter).union(Set(pathComponentsParameter))
            return function.parameters.filter { parameters.contains($0) }
        }
    }
}
