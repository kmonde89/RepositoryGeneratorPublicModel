//
//  ReturnValue.swift
//  
//
//  Created by Kévin Mondésir on 18/05/2023.
//

import Foundation

extension RepositoryGeneratorPublicModel {
    public enum ReturnValue: Codable {
        case publisher(output: String, error: String)
        case standard(type: String)
        
        public var description: String {
            switch self {
            case .publisher(let output, let error):
                return "AnyPublisher<\(output), \(error)>"
            case .standard(let type):
                return type
            }
        }
        
        public var publisherMapError: String {
            guard case let .publisher(_, error) = self else {
                return ""
            }
            guard error != "Error" else {
                return ".mapError { $0 as Error }"
            }
            return ".mapError { <#T## insert error mapping to \(error)###".appending("> }")
        }
        
        public var resultTypeDecription: String {
            guard case let .publisher(output, error) = self else {
                return ""
            }
            return "Result<\(output), \(error)>"
        }
    }
}
