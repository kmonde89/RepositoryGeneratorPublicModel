//
//  Response.swift
//  
//
//  Created by Kévin Mondésir on 19/05/2023.
//

import Foundation

extension RepositoryGeneratorPublicModel {
    public struct Response {
        public let outputDTO: String?
        
        public init(outputDTO: String?) {
            self.outputDTO = outputDTO
        }
        
        public var description: String {
            guard case .some(let dtoType) = self.outputDTO else {
                return """
.responsePublisher()
\(createIndentation(3)).map { _ in }
"""
            }
            return """
.responseDecodablePublisher(of: \(dtoType).self)
\(createIndentation(3)).map { \(createPlaceHolder("map to model")) }
"""
        }

        public func requestResultDescription(_ errorType: String) -> String {
            guard let outputDTO,
                  !outputDTO.isEmpty else {
                return "Result<Void, \(errorType)>"
            }
            return "Result<\(outputDTO), \(errorType)>"
        }
    }
}
