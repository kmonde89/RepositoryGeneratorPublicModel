//
//  Operation.swift
//  
//
//  Created by Kévin Mondésir on 19/05/2023.
//

import Foundation

extension RepositoryGeneratorPublicModel {
    public struct Operation: Codable {
        public let function: Function
        public let requestConfiguration: RequestConfiguration
        public let responses: [Response]
        
        public init(function: Function, requestConfiguration: RequestConfiguration, responses: [Response]) {
            self.function = function
            self.requestConfiguration = requestConfiguration
            self.responses = responses
        }
    }
}
