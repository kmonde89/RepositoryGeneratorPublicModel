//
//  ReturnValue.swift
//  
//
//  Created by Kévin Mondésir on 18/05/2023.
//

import Foundation

extension RepositoryGeneratorPublicModel {
    public struct ReturnValue: Codable {
        let output: String
        let error: String
        
        public var description: String {
            return "AnyPublisher<\(output), \(error)>"
        }
        
        public var publisherMapError: String {
            guard error != "Error" else {
                return ".mapError { $0 as Error }"
            }

            return ".mapError { \(createPlaceHolder("insert error mapping to \(error)")) }"
        }
        
        public var resultTypeDecription: String {
            return "Result<\(output), \(error)>"
        }
    }
}
